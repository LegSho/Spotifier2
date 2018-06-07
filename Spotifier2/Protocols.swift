//
//  Protocols.swift
//  Spotifier2
//
//  Created by Igor Tabacki on 6/6/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}



extension ReusableView where Self: UIView {                 // ogranicavam ga samo na primenu na ono sto nasledjuje UIView  ----- PROTOCOL CONSTRAINT !
    static var reuseIdentifier: String {                      // protocol extension -> gde god se primenjuje ovaj protocol, automatski ce biti kreiran i reuseIdentifier
        return String(describing: self)                          // prosledjivanje samog tipa (self) ce mi vracati BAS IME TOG tipa !!!!! ***** SMANJENA VEROVATNOCA GRESKE SAMO NA INTERFACE BUILDER
    }
}
