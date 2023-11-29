//
//  HealthAppIntent.swift
//  WallPaper-CoreData
//
//  Created by MAC on 29/11/2023.
//

import Foundation


import SwiftUI
import WidgetKit
import AppIntents

struct HealthConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "HealthConfigurationAppIntent"
    static var description = IntentDescription("This is an example widget.")
    
    // An example configurable parameter.
    @Parameter(title: "Pick a Health")
    var healthSrc: HealthSource
}

