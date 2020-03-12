//
//  JokeView.swift
//  RandomNorris
//
//  Created by Siqueira on 12/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import UIKit

protocol JokeViewDelegate: AnyObject {
    func onTapJokeButton()
}

final class JokeView: UIView {
    // MARK: - Views
    private lazy var jokeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(String.localized(by: "GetJoke"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20.0
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(didTapJokeButton), for: .touchUpInside)

        return button
    }()

    // MARK: - Attributes
    private weak var delegate: JokeViewDelegate?

    // MARK: - Initializer
    init(with delegate: JokeViewDelegate?) {
        super.init(frame: .zero)

        self.delegate = delegate

        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc private func didTapJokeButton() {
        delegate?.onTapJokeButton()
    }
}

// MARK: - ViewConfiguration
extension JokeView: ViewConfiguration {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            jokeButton.topAnchor.constraint(equalTo: self.topAnchor),
            jokeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            jokeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            jokeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func buildViewHierarchy() {
        self.addSubview(jokeButton)
    }

    func configureViews() {
        jokeButton.backgroundColor = .black
    }
}
