//
//  SquareProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI
import WidgetKit


struct SquareProvider: AppIntentTimelineProvider {

    
    func placeholder(in context: Context) -> SquareEntry {
        SquareEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }

    func snapshot(for configuration: LockSquareConfigurationAppIntent, in context: Context) async -> SquareEntry {
        WidgetCenter.shared.reloadAllTimelines()
        return SquareEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }
    
    func timeline(for configuration: LockSquareConfigurationAppIntent, in context: Context) async -> Timeline<SquareEntry> {
        print("DEBUG: goto timeline")

        let entry = SquareEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
        
        return Timeline(entries: [entry], policy: .never)
    }
}

struct SquareEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let size: CGSize
}
