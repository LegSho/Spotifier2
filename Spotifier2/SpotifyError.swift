//
//  SpotifyError.swift
//  Spotifier
//
//  Created by Igor Tabacki on 4/30/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation

enum SpotifyError: Error {
    case urlError(URLError)
    case invalidResponse
    case noData
}

