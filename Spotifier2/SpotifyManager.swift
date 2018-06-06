//
//  SpotifyManager.swift
//  Spotifier
//
//  Created by Igor Tabacki on 4/30/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import SwiftyOAuth


typealias JSON = [String: Any]


final class SpotifyManager {
    
    private var requests: [APIRequest] = []                                     // niz requestova koji su dosli sa neta !
    
    private var isFetchingTokenInProgress = false {                             //  zapamti jos jednom: didSet se nikada ne izvrsava pri init objekta tj. na SAMOM POCETKU
        didSet {
            if isFetchingTokenInProgress { return }
            processPendingRequests()
        }
    }
    
//    private var callBack: Callback?
 
    
//        private var oauthProvider = Provider.spotify(clientID: "badf9c13b4604dd3b6f3335df4542100",
//                                                     clientSecret: "a889c1f8e98f4e07a93fbb56ce5d19a5")          // Academ Profile
    
    private var oauthProvider = Provider.spotify(clientID: "f31d18707955410790ecb6dba1cba976",
                                                 clientSecret: "067d574b849547729dcf718e4ecdf689")            // moj Profile

//    BQAagVCo6YQEPsMmM8ZKIUu5lTCfLOwR3ywzxgmMKwWZ5SPWzp4K7xdjhu2E4wDEADoqigthnhvCXqjhBb8
    enum Path {
        
        static let host = "https://api.spotify.com/v1/"
        
        case search                 (q: String, type: SpotifyManager.SearchType)    //  "href": "https://api.spotify.com/v1/search?q=\(q)&type=\(type)"
        
        case getAListOfNewReleases  (countryCode: String)                           //"href": "https://api.spotify.com/v1/browse/new-releases?country=\(countryCode)"
        case getAnArtist            (id: String)                                    //"href": "https://api.spotify.com/v1/artists/\(id)"




        private var url: URL {
            var address = ""
            switch self {
            case .search(let q, let type):
                address = "\(Path.host)search?=\(q)&type=\(type.rawValue)"
            case .getAListOfNewReleases(let countryCode):                                                           // *
                address = "\(Path.host)browse/new-releases?country=\(countryCode)"
            case .getAnArtist(let id):                                                                              // **
                address = "\(Path.host)artists/\(id)"
            }
            
            return URL(string: address)!                           // jer Query String je razlicit za druge case-ove (search, getAListOfNewRealeases itd.)
        }
        
        private var method: String {
            switch self {
            case .search :
                return "GET"
            case .getAListOfNewReleases :                                                                            // *
                return "GET"
            case .getAnArtist:                                                                                       // **
                return "GET"
            }
        }
        
        var urlRequest: URLRequest {                                // NIJE PRIVATE jer nam jedino on treba van ovog scope-a !
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method
            return urlRequest
        }
    }
}



//  u slucaju kada bih pisao Funkciju koja ide na samo jedan tip, onda je najbolje to pisati kao METOD na TOM TIPU ! ! ! ! !
//  A METOD KOJI NEMA PARAMETRE -> pisem kao COMPUTED PROTERTY ! ! ! ! !



//           C   A   L  L               ------>>>        O  A  U  T  H         -------->>>       E    X   E    C   U    T    E ( URLSession )




extension SpotifyManager {
    
    typealias Callback = (Data?, SpotifyError?) -> Void
    typealias APIRequest = (path: Path, callback: Callback)         // ova dva u tuple APIRequest ! ! !  -- let urlRequest = path.urlRequest &
                                                                    // self.callback = spotifyCallback -> moram cuvati OBA - PUT i CALLBACK dok ne dobijem ACCESS TOKEN!
                                                                    // i onda ovaj TUPLE u let apiReq iskoristim
                                                                    // path - ENTRANCE     i      spotifyCallback - EXIT
    func call(path: Path, spotifyCallback: @escaping Callback) {
        let apiReq = (path, spotifyCallback)                        // cuvam ih u var requests: [APIRequest] = []
        oauth(apiReq)
    }
}



private extension SpotifyManager {

    func oauth(_ apiReq: APIRequest) {
        
        guard let token = oauthProvider.token else {                // do we have valid access token?
            self.requests.append(apiReq)                            // if not, then save request into requests array,
            fetchToken()                                            // Is fetching token in progress ?
            return
        }
        
        if !token.isValid {                                         // if we have it then we check its validation
            self.requests.append(apiReq)
            refreshToken()
            return
        }
        
        
        var urlRequest = apiReq.path.urlRequest                     // GOT TOKEN & IT'S VALID -----> CAN ASKED FOR REQUEST
        
        if let tokenType = token.tokenType {
            switch tokenType {
            case .bearer:
                let value = "Bearer \(token.accessToken)"
                urlRequest.addValue(value, forHTTPHeaderField: "Authorization")
            }
        }
        
        execute(urlRequest: urlRequest, spotifyCallback: apiReq.callback)
    }
    
    
    func processPendingRequests() {
                                            // UVEK LOKALNU PROMENLJIVU i u nju guram spoljne, da ne bi crashovao ubacivanjem mozda nekog novog requesta u toku rada
        let reqs = self.requests                                       // zbog situacije gde bi moglo da se doda u medjuvremenu novi request
       
        for req in reqs {                                              // kada se izvrsava for za requests,i da app zabode, radim uvek sledece:
            oauth(req)
        }
        self.requests = []                                             // brisanje a sl.put ponovo sa novim reqs !
    }
    
    
    func execute(urlRequest: URLRequest, spotifyCallback: @escaping Callback) {         // f-ja koja se zove iz closure-a
        let task = URLSession.shared.dataTask(with: urlRequest) {
            data, urlResponse, error in
            spotifyCallback(data, nil)
        }
        task.resume()
    }
    
    
    func fetchToken() {
        if isFetchingTokenInProgress { return }                        // ako upravo HVATA vec neki - ne radi fetch , samo ako nema
        isFetchingTokenInProgress = true
        
        
        oauthProvider.authorize {                                      // DOHVATA TOKEN ako ga nemamo
            [unowned self] result in                                   // kad god IMAM SELF UNUTAR CLOSURE - IDE ILI WEAK ILI UNOWNED UZ vracanu vrednost!!!!!
            
            switch result {                                            // result - enum sa success, failure
            case .success:
                self.isFetchingTokenInProgress = false
                
            case .failure(let error):
                print("Failure Error on Fetch Token function: \(error).")
            }
        }
    }
    
    //     FUNCTIONS FOR SCENARIOS WHEN USER DOESN'T HAVE VALID TOKEN AND WHAT WOULD WE DO THEN ?  ?  ?
    
    func refreshToken() {
        fetchToken()                                                    // JER SPOTIFY NEMA REFRESH TOKEN pa zato ide samo ponovni fetch()
    }
    
}







//DESCRIPTION



/*
 final class SpotifyManager {
 // Idealna arhitektura za projektovanje url requesta je enum u kombinaciji sa associated values
 
 enum Path {
 static let host = "https://api.spotify.com/v1/"
 
 case search(q: String, type: SearchType)
 
 //      private jer mi ne treba nigde van ovog scope-a
 private var url: URL {
 var s = ""
 
 switch self {
 
 case .search(let q, let type):
 s = " \( Path.host )search?q=\(q)&type=\( type.rawValue )"
 }
 
 return URL(string: s)!
 //            ! - jer ovo i treba da crashuje jer ovo bi bila programerska greska a ne korisnicka !
 }
 
 private var method: String {
 switch self {
 case .search:
 return "GET"
 }
 }
 
 var urlRequest: URLRequest {
 var urlRequest = URLRequest(url: url)
 urlRequest.httpMethod = method
 return urlRequest
 }
 
 
 }
 
 //    NE STAVLJAM DEFAULT jer pri dodavanju nekog NOVOG CASE-a compiler ce svuda izbacivati gde treba da dodam za dati slucaj! ! ! ! !
 }
 
 
 
 
 
 
 
 extension SpotifyManager {
 
 func call(path: Path, spotifyCallback:  @escaping (JSON?, SpotifyError?) -> Void) {
 
 
 let urlRequest = path.urlRequest
 
 let task = URLSession.shared.dataTask(with: urlRequest) {
 data, urlResponse, error in
 
 //  povratak sa Neta (data,urlResponse, error)
 
 //            @escaping - govorimo time da smo svesni da ce vrednosti unutar callback-a nastaviti da "ZIVE" jos neko izvesno vreme cak i kad se zavrsi f-ja , jer su stavljeni unutar URLSession-a
 
 //            TELO CALLBACK-a se ne nalazi u datoj funk nego u prethodnoj koja poziva ovu i celog ga tamo prosledjuje,
 //            ovde se samo poziva zajedno sa parametrima koji se tamo prosledjuju
 
 let json: JSON = [:]
 spotifyCallback(json, nil)
 }
 task.resume()
 }
 }
 */



