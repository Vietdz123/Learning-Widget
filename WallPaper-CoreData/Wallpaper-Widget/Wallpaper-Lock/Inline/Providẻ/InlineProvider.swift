//
//  InlineProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI
import WidgetKit

struct InlineProvider: AppIntentTimelineProvider {
    
    
    func placeholder(in context: Context) -> InlineEntry {
        InlineEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }
    
    func snapshot(for configuration: LockInlineConfigureAppIntent, in context: Context) async -> InlineEntry {
        WidgetCenter.shared.reloadAllTimelines()
        return InlineEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }
    
    func timeline(for configuration: LockInlineConfigureAppIntent, in context: Context) async -> Timeline<InlineEntry> {
        print("DEBUG: goto timeline")
        
        let entry = InlineEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
        
        return Timeline(entries: [entry], policy: .never)
    }
}

struct InlineEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let size: CGSize
}
