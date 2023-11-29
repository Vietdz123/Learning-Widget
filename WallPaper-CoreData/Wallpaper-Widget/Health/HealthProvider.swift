//
//  HealthProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 29/11/2023.
//

import SwiftUI
import WidgetKit
import AppIntents

struct HealthProvider: AppIntentTimelineProvider {
    
    
    func placeholder(in context: Context) -> HealthEntry {
        HealthEntry(date: Date(), text: "choose", size: context.displaySize)
    }
    
    func snapshot(for configuration: HealthConfigurationAppIntent, in context: Context) async -> HealthEntry {
        WidgetCenter.shared.reloadAllTimelines()
        return HealthEntry(date: Date(), text: "choose", size: context.displaySize)
    }
    
    func timeline(for configuration: HealthConfigurationAppIntent, in context: Context) async -> Timeline<HealthEntry> {
        print("DEBUG: goto timeline")
        
        let entry = HealthEntry(date: Date(), text: configuration.healthSrc.actualName, size: context.displaySize)
        
        return Timeline(entries: [entry], policy: .never)
    }
}

struct HealthEntry: TimelineEntry {
    let date: Date
    let text: String
    let size: CGSize
}
