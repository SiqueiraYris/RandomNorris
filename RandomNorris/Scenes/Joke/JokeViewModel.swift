//
//  JokeViewModel.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

protocol JokeViewModelProtocol {
    var joke: Dynamic<Joke?> { get }
    var error: Dynamic<Error?> { get }
    var loading: Dynamic<Bool> { get }

    func fetchJoke()
}

final class JokeViewModel: JokeViewModelProtocol {
    // MARK: - Attributes
    private var service: JokeServiceProtocol
    var joke: Dynamic<Joke?> = Dynamic(nil)
    var error: Dynamic<Error?> = Dynamic(nil)
    var loading: Dynamic<Bool> = Dynamic(false)

    // MARK: - Initializer
    init(service: JokeService = JokeService()) {
        self.service = service
    }

    // MARK: - Functions
    func fetchJoke() {
        let route = JokeRoute.fetchJoke
        loading.value = true

        service.fetchJoke(route) { [weak self] (result: Result<JokeResponse, ErrorHandler>) in
            guard let self = self else { return }

            self.loading.value = false

            switch result {
            case .success(let dataSource):
                self.joke.value = dataSource.value

            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
