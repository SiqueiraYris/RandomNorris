//
//  JokeRoute.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

enum JokeRoute: NetworkRoute {
    case fetchJoke

    var configuration: RequestConfiguration {
        switch self {
        case .fetchJoke:
            let config = RequestConfiguration(host: "api.icndb.com",
                                       path: "/jokes/random/",
                                       method: .get,
                                       encoding: .url)
            return config
        }
    }
}
