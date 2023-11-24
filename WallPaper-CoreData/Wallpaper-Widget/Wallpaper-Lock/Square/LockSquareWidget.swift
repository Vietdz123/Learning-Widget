//
//  LockSquareWidget.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import Foundation

import WidgetKit
import SwiftUI
import AVFoundation

@available(iOS 17.0, *)
struct LockSquareWidget: Widget {
    let kind: String = "LockSquareWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: LockSquareConfigurationAppIntent.self,
                               provider: SquareProvider()) { entry in
            SquareWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .supportedFamilies([ .accessoryCircular ])
        
    }
}
