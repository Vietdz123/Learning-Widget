//
//  AppIntent.swift
//  Wallpaper-GifWidget
//
//  Created by MAC on 17/11/2023.
//

import WidgetKit
import AppIntents

import AppIntents

struct ConfigurationLockAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
