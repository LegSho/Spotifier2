//
//  DataManager.swift
//  Spotifier
//
//  Created by Igor Tabacki on 4/30/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//
//
//
//   MANAGER ZA KOMUNIKACIJU IZMEDJU       UI(ViewControllera)   i    "PRAVOG" MANAGERA ZA KOMUNIKACIJU SA NETOM (ovde: SPOTIFYMANAGER) ! ! ! ! !

import Foundation

final class DataManager {
    private init() {}
    static let shared = DataManager()
    
    private var spotifyManager = SpotifyManager()
}


extension DataManager {
    
    typealias searchCallback = ([Artist], [Album], [Track], DataError? ) -> Void
    
    func search(for string: String,
                type: SpotifyManager.SearchType,
                dataCallBack:  @escaping searchCallback) {
        
        let path: SpotifyManager.Path = .search(q: string, type: type)
        
        spotifyManager.call(path: path) {
            data, spotifyError in
            
            if let spotifyError = spotifyError {                                                            // if there's an Error put it into DataError !
                DispatchQueue.main.async { dataCallBack ([], [], [], DataError.spotifyError(spotifyError))}
                return
            }
            
            // PROCESS DATA  ---  KONVERZIJA IDE U DATA MANAGER iz razloga jer SpotifyManager ima za cilj samo da iskomunicira sa webom, uzme podatke i prosledi ih onom manageru koji je te podatke trazio a sve dalje konverzije i obrada data ide u ovom manageru ! ! ! ! !
            
            
            guard let data = data else { return }                                                           // if there's not an Error & we get a Data
 
            
            
            let decoder = JSONDecoder()
            do {
                let text = String(data: data, encoding: .utf8)!
                print(text)
                switch type {
                    
                case .artist:
                    let artistResponse = try decoder.decode(SpotifyArtistResponse.self, from: data)
                    DispatchQueue.main.async { dataCallBack(artistResponse.artists.items, [], [], nil ) }
                    
                case .album:
                    DispatchQueue.main.async { dataCallBack([], [], [], nil) }
                    break
                    
                case .track:
                    DispatchQueue.main.async { dataCallBack([], [], [], nil) }
                    break
                }
                
            } catch let error {
                print("Error on decoding data from net (DataManager/line 65): \(error)")           // tipican primer : 1 deo za prikaz samom Developeru
                DispatchQueue.main.async { dataCallBack([], [], [], DataError.internalError) }     // tipican primer : 2 deo za prikaz samom Korisniku
            }
        }
    }
}



