//
//  SearchController.swift
//  Spotifier
//
//  Created by Igor Tabacki on 4/30/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

final class SearchController: UIViewController {
    
    // MARK: - Variables and IBOutlets
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
    //     MARK: - Main function
    
    func search(for string: String) {
        
        dataManager.search(for: string,
                           type: searchType) {
                            artists, albums, tracks, dataError in
                            
                            if let dataError = dataError { return }
                            
                            self.artists = artists
                            self.albums = albums
                            self.tracks = tracks
                            
                            self.collectionView.reloadData()
        }
    }
}

//    MARK: - View Life Cycles
extension SearchController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cleanupUI()
    }
    
    
    //          ako koristim CUSTOM FLOW LAYOUT ovaj metod se izvrsava saam unutar UI-a
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()                          // sve sracunato do tad - "BACI!" i ponovo sracunaj, sad za novi polozaj uredjaja!
    }
    
    //    MARK: - Internal
    private func cleanupUI() {
        searchField.text = nil
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let s = sender.text, s.count > 2 else {
            artists.removeAll()
            collectionView.reloadData()
            return
        }
        search(for: s)
    }
}

// MARK: - Collection View part
extension SearchController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch searchType {
        case .artist :
            return artists.count
        case .album :
            return albums.count
        case .track :
            return tracks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.reuseIdentifier, for: indexPath) as! SearchCell
        switch searchType {
        case .artist :
            let artist = artists[indexPath.item]
            cell.populate(with: artist)
        case .album :
            break
        case .track :
            break
        }
        return cell
    }
    
    //    poslednje posle svih implementacija - u okviru Storyboarda moram spojiti dataSource sa CollectionView (isto i TableView npr.) sa Search Controller-om
    
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError("Must be used with FlowLayout only.") }
        
        var itemSize = layout.itemSize
        
        var availableWidth = collectionView.bounds.width
        availableWidth -= (layout.sectionInset.left + layout.sectionInset.right)
        
        let columns = floor(availableWidth / (itemSize.width + layout.minimumInteritemSpacing))
        availableWidth -= ( columns - 1) * layout.minimumInteritemSpacing
        
        let w = availableWidth / columns
        
        itemSize.width = w
        
        return itemSize
    }
    
    //      poslednje posle svih implementacija - u okviru Storyboarda moram spojiti delegate sa CollectionView (isto i TableView npr.) sa Search Controller-om
    
}


