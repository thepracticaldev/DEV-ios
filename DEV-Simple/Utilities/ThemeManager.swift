//
//  ThemeManager.swift
//  DEV-Simple
//
//  Created by Daniel Chick on 11/27/20.
//  Copyright © 2020 DEV. All rights reserved.
//

import UIKit
import ForemWebView

class ThemeManager {
    private(set) static var useDarkMode = false

    static func applyTheme(to viewController: ViewController) {
        guard let webView = viewController.webView, let theme = webView.userData?.theme() else { return }

        let config = getThemeColor(for: theme)

        viewController.navigationToolBar.barTintColor = config.barTintColor
        viewController.view.backgroundColor = config.backgroundColor

        viewController.navigationToolBar.isTranslucent = !useDarkMode
        viewController.safariButton.tintColor = useDarkMode ? UIColor.white : ThemeColors.darkBackgroundColor
        viewController.backButton.tintColor = useDarkMode ? UIColor.white : ThemeColors.darkBackgroundColor
        viewController.forwardButton.tintColor = useDarkMode ? UIColor.white : ThemeColors.darkBackgroundColor
        viewController.refreshButton.tintColor = useDarkMode ? UIColor.white : ThemeColors.darkBackgroundColor
        viewController.activityIndicator.color = useDarkMode ? UIColor.white : ThemeColors.darkBackgroundColor
    }

    private static func getThemeColor(for theme: ForemWebViewTheme) -> ThemeConfig {
        switch theme {
        case .night:
            useDarkMode = true
            return ThemeConfig.night
        case .hacker:
            useDarkMode = true
            return ThemeConfig.hacker
        case .pink:
            useDarkMode = false
            return ThemeConfig.pink
        case .minimal:
            useDarkMode = false
            return ThemeConfig.minimal
        default:
            return ThemeConfig.base
        }
    }
}

private struct ThemeConfig {
    let barTintColor: UIColor
    let backgroundColor: UIColor
}

extension ThemeConfig {
    private static let devPink = UIColor(red: 250/255, green: 70/255, blue: 129/255, alpha: 1)

    static let night = ThemeConfig(barTintColor: ThemeColors.darkBackgroundColor,
                                   backgroundColor: ThemeColors.darkBackgroundColor)
    static let hacker = ThemeConfig(barTintColor: .black, backgroundColor: .black)
    static let pink = ThemeConfig(barTintColor: devPink, backgroundColor: devPink)
    static let base = ThemeConfig(barTintColor: .white, backgroundColor: .white)
    static let minimal = ThemeConfig(barTintColor: .white, backgroundColor: .white)
}