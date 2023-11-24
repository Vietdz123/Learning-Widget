//
//  LockRectAndSquareWidget.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import WidgetKit
import SwiftUI
import AVFoundation

@available(iOS 17.0, *)
struct LockRectangleWidget: Widget {
    let kind: String = "LockRectangleWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: LockRectangleConfigurationAppIntent.self,
                               provider: RectangleProvider()) { entry in
            RectangleWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .supportedFamilies([ .accessoryRectangular ])
        
    }
}
