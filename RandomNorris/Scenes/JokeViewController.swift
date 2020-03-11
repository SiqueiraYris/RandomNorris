//
//  JokeViewController.swift
//  RandomNorris
//
//  Created by Siqueira on 11/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import UIKit

final class JokeViewController: UIViewController {
    // MARK: - Attributes
    private let viewModel: JokeViewModelProtocol

    // MARK: - Initializer
    init(with viewModel: JokeViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: String(describing: JokeViewController.self), bundle: .main)
//        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchJoke()
    }
}
