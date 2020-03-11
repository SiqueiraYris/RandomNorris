//
//  Joke.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Random: Codable {
    let type: String
    let value: Value
}

// MARK: - Value
struct Value: Codable {
    let id: Int
    let joke: String
}
