//
//  NetworkRoute.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

protocol NetworkRoute {
    var configuration: RequestConfiguration { get }
}
