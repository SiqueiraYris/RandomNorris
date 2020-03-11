//
//  JokeViewModel.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

protocol JokeViewModelProtocol {
    func fetchJoke()
}

final class JokeViewModel: JokeViewModelProtocol {
    // MARK: - Attributes
    private var service: JokeServiceProtocol

    // MARK: - Initializer
    init(service: JokeService = JokeService()) {
        self.service = service
    }

    func fetchJoke() {
        let route = JokeRoute.fetchJoke
        
        service.fetchJoke(route) { [weak self] (result: Result<Random, ErrorHandler>) in
            switch result {
            case .success(let dataSource):
                print("dataSource \(dataSource)")
            case .failure(let error) :
                print("error \(error)")
            }
        }
    }
}
