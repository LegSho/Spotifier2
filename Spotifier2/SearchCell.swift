//
//  SearchCell.swift
//  SpotifyApp
//
//  Created by Igor Tabacki on 6/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

import Kingfisher                                                       // za dohvatanje SLIKA sa neta - imageCacher!


// Uvek FINAL pa posle skidaj ako ti treba nasledjivanje


final class SearchCell: UICollectionViewCell, ReusableView {  
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var photoView: UIImageView!
    
    
    func populate(with artist: Artist) {
        label.text = artist.name
        
        guard let url = artist.images.first?.url else { return }
        photoView.kf.setImage(with: url)
    }
    
    
    func populate(with string: String) {
        label.text = string
    }
}
