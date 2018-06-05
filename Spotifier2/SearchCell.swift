//
//  SearchCell.swift
//  SpotifyApp
//
//  Created by Igor Tabacki on 6/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

// Uvek FINAL pa posle skidaj ako ti treba nasledjivanje

final class SearchCell: UICollectionViewCell {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var photoView: UIImageView!
    
    
    func populate(with artist: Artist) {
        
    }
    
    
    func populate(with string: String) {
        label.text = string
    }
}
