//
//  LockRectProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//


import WidgetKit
import SwiftUI

struct RectangleProvider: AppIntentTimelineProvider {

    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }

    func snapshot(for configuration: LockRectangleConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        WidgetCenter.shared.reloadAllTimelines()
        return SimpleEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }
    
    func timeline(for configuration: LockRectangleConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        print("DEBUG: goto timeline")

        let entry = SimpleEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
        
        return Timeline(entries: [entry], policy: .never)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let size: CGSize
}
