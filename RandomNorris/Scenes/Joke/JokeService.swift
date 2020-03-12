//
//  JokeService.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

typealias FetchJokeResult = (Result<JokeResponse, ErrorHandler>) -> Void

protocol JokeServiceProtocol: AnyObject {
    func fetchJoke(_ route: JokeRoute, completion: @escaping FetchJokeResult)
}

final class JokeService {
    // MARK: - Attributes
    let networkManager: NetworkManagerProtocol

    // MARK: - Initializer
    init(networking: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networking
    }
}

// MARK: - JokeServiceProtocol
extension JokeService: JokeServiceProtocol {
    func fetchJoke(_ route: JokeRoute, completion: @escaping FetchJokeResult) {
        networkManager.requestObject(with: route.configuration, completion: completion)
    }
}
