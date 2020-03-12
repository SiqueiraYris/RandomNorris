//
//  JokeViewController.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import UIKit

final class JokeViewController: UIViewController {
    // MARK: - Components
    private lazy var jokeView: JokeView = {
        let view = JokeView(with: self)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - Attributes
    private let viewModel: JokeViewModelProtocol

    // MARK: - Initializer
    init(with viewModel: JokeViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinds()
    }

    // MARK: - Functions
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(jokeView)

        NSLayoutConstraint.activate([
            jokeView.heightAnchor.constraint(equalToConstant: 50.0),
            jokeView.widthAnchor.constraint(equalToConstant: 130.0),
            jokeView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            jokeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    private func setupBinds() {
        viewModel.joke.bind { [weak self] joke in
            guard let self = self, let joke = joke else { return }

            self.showAlert(message: joke.joke)
        }

        viewModel.error.bind { [weak self] error in
            guard let self = self, let error = error else { return }

            self.showAlert(title: String.localized(by: "Error"), message: error.localizedDescription)
        }
    }
}

// MARK: - JokeViewDelegate
extension JokeViewController: JokeViewDelegate {
    func onTapJokeButton() {
        viewModel.fetchJoke()
    }
}
