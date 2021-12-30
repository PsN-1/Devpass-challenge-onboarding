//
//  SettingsModel.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 30/12/21.
//

import Foundation

struct Option {
    var header: String?
    var items: [ActiveItem?]
}

struct ActiveItem {
    var name: String?
    var isActive: Bool?
}

struct Settings {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    func getSettingsOptions() -> [Option] {
        [
            Option(
                header: "User Preferences",
                items: [ActiveItem(name: "Theme Color", isActive: true),
                        ActiveItem(name: "Font Size", isActive: true)]),
            
            Option(header: "APP VERSTION",
                   items: [ActiveItem(name: "Version " + (appVersion ?? "?"), isActive: false)]),
        ]
    }
}
