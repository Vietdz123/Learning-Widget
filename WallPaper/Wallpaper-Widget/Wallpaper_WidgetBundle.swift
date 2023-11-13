//
//  Wallpaper_WidgetBundle.swift
//  Wallpaper-Widget
//
//  Created by MAC on 19/10/2023.
//

import WidgetKit
import SwiftUI
import AVFoundation

@main
@available(iOS 17.0, *)
struct Wallpaper_WidgetBundle: WidgetBundle {
    var body: some Widget {
        WallpaperWidget()
    }
}

@available(iOS 17.0, *)
struct WallpaperWidget: Widget {
    let kind: String = "WallpaperWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: Provider()) { entry in
            WallpaperWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .onAppear {

                }
        }
        .contentMarginsDisabled()
        .supportedFamilies([ .systemMedium, .accessoryCircular,  .accessoryRectangular,])
        
//           systemSmall, .systemMedium, .systemLarge ,
//                            .accessoryCircular, .accessoryInline, .accessoryRectangular])
        
        
        
    }
}
