//
//  SearchController.swift
//  Spotifier
//
//  Created by Igor Tabacki on 4/30/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

final class SearchController: UIViewController {
    
    @IBOutlet private weak var searchField: UITextField!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var dataManager: DataManager = .shared
    
    //    zbog errora "has no initializers" koji nastaje kad nisam zadao ili default value ili optional property, nikada "ne zelim" da override-ujem initilizer ViewControllera, zato za pocetak, kao nedostatak "plumbera", jer jedino sa cim krecem je AppDelegate i UIVCs, za sada za svaki "Manager" pravim ga kao SINGLETON jer kroz celu app postojace npr. samo jedan DataManager ili samo jedan SpotifyManager itd.
    
    //    AAAAALIIIIII , najveci problem u upotrebi SINGLETON-a je taj sto je takvu strukturu NEMOGUCE TESTIRATI ... zatoo ...
    
    //  pravim LOKALNU PROMENJIVU dataManager i kroz nju cu provlaciti vezu sa singletonom a NE DA KONSTANTNO GADJAM DRUGI OBJEKAT !
    
    private var artists: [Artist] = []
    private var albums: [Album] = []
    private var tracks: [Track] = []
    
    var searchType: SpotifyManager.SearchType = .artist
}



extension SearchController {
    
    func search(for string: String) {
        
        dataManager.search(for: string,
                           type: searchType) {
            artists, albums, tracks, dataError in
            
            if let dataError = dataError { return }
            
            self.artists = artists
            self.albums = albums
            self.tracks = tracks
        }
    }
}

extension SearchController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cleanupUI()
    }
    
    private func cleanupUI() {
        searchField.text = nil
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let s = sender.text, s.count > 2 else { return }
        search(for: s)
    }
}

extension SearchController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.populate(with: "Name \(indexPath.item)")
        
        return cell
    }
    
//    poslednje posle svih implementacija - u okviru Storyboarda mogu da spojim dataSource sa CollectionView (isto i TableView npr.) sa Search Controller-om
    
}


