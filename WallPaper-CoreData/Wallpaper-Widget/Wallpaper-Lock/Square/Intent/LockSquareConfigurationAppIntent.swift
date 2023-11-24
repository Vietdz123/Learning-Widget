//
//  LockSquareConfigurationAppIntent.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//



import WidgetKit
import AppIntents


struct LockSquareConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "LockSquareConfigurationAppIntent"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
