//
//  Extension+UIButton.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit

extension UIButton.Configuration {
    static func imageTitle(title: String, subtitle: String?, image: UIImage?) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.subtitle = subtitle
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = .black
        configuration.image = image
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        return configuration
    }
}
