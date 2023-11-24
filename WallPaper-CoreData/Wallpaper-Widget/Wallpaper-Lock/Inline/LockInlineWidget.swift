//
//  LockInlineWidget.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//


import WidgetKit
import SwiftUI
import AVFoundation

@available(iOS 17.0, *)
struct LockInlineWidget: Widget {
    let kind: String = "LockInlineWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: LockInlineConfigureAppIntent.self,
                               provider: InlineProvider()) { entry in
            InlineWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .supportedFamilies([ .accessoryInline ])
        
    }
}
