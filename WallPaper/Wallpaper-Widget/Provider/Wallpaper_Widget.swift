//
//  Wallpaper_Widget.swift
//  Wallpaper-Widget
//
//  Created by MAC on 19/10/2023.


import WidgetKit
import SwiftUI


struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SourceImageEntry {
        print("DEBUG: goto placeholder")
        return SourceImageEntry(sourceImage: ImageSource(id: "bird", name: "bird"), size: context.displaySize)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SourceImageEntry {
        print("DEBUG: goto snapshot")
        return SourceImageEntry(sourceImage: ImageSource(id: "bird", name: "bird"), size: context.displaySize)
        SourceImageEntry(sourceImage: configuration.imageSrc, size: context.displaySize)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SourceImageEntry> {
        
        print("DEBUG: goto timeline")
        print("DEBUG: \(configuration.imageSrc.images.count) siuuu")
        if configuration.imageSrc.images.isEmpty {
            ImageDataModel.shared.shouldShowPlaceHolder = true
        } else {
            ImageDataModel.shared.shouldShowPlaceHolder = false
            ImageDataModel.shared.images = configuration.imageSrc.images
        }

        let entry = SourceImageEntry(sourceImage: configuration.imageSrc, size: context.displaySize)
        
        return Timeline(entries: [entry], policy: .never)
    }
}







struct WallpaperWidget: Widget {
    let kind: String = "WallpaperWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: Provider()) { entry in
            WallpaperWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.contentMarginsDisabled()
    }
}

