//
//  LockInlineIntent.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import WidgetKit
import AppIntents


struct LockInlineConfigureAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "LockInlineConfigureAppIntent"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}



