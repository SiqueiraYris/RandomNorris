//
//  Joke.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

struct JokeResponse: Codable {
    let type: String
    let value: Joke
}
