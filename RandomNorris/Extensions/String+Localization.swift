//
//  String+Localization.swift
//  RandomNorris
//
//  Created by Siqueira on 12/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import Foundation

extension String {
    static func localized(by key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    static func localizedComplement(by key: String, with complement: CVarArg...) -> String {
        return String(format: NSLocalizedString(key, comment: "%@"), arguments: complement)
    }
}
