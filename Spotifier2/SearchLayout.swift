//
//  CustomCollectionViewFlowLayout.swift
//  Spotifier2
//
//  Created by Igor Tabacki on 6/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

final class SearchLayout: UICollectionViewFlowLayout {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemSize = CGSize(width: 110, height: 200)                      // start iz UI-a
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        scrollDirection = .vertical                                     // inace .vertical je po default-u
        }
}

extension SearchLayout {
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        guard let oldBounds = collectionView?.bounds else { return false }
//
//        return oldBounds.size != newBounds.size
//    }
//
//    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
//
//        guard let context = super.invalidationContext(forBoundsChange: newBounds) as? UICollectionViewFlowLayoutInvalidationContext else { return super.invalidationContext(forBoundsChange: newBounds)}
//        context.invalidateFlowLayoutAttributes = true
//        return context
//    }
}
