//
//  UIViewController+Extension.swift
//  RandomNorris
//
//  Created by Siqueira on 12/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import UIKit

// MARK: - Show Alert
extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: String.localized(by: "Ok"), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Show Activity Indicator
extension UIViewController {
    var activityIndicatorTag: Int { return 999999 }

    func startActivityIndicator(style: UIActivityIndicatorView.Style = .large, location: CGPoint? = nil) {
        let location = location ?? self.view.center

        let backgroundView: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        backgroundView.center = location
        backgroundView.tag = self.activityIndicatorTag
        backgroundView.alpha = 0.9
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 15
        backgroundView.backgroundColor = .black

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.style = .large
        activityIndicator.color = .white
        
        activityIndicator.center = CGPoint(x: backgroundView.frame.size.width / 2,
                                               y: backgroundView.frame.size.height / 2)

        DispatchQueue.main.async {
            backgroundView.addSubview(activityIndicator)
            self.view.addSubview(backgroundView)
            activityIndicator.startAnimating()
        }
    }

    func stopActivityIndicator() {
        DispatchQueue.main.async {
            for subview in self.view.subviews where subview.tag == self.activityIndicatorTag {
                subview.removeFromSuperview()
            }
        }
    }
}
