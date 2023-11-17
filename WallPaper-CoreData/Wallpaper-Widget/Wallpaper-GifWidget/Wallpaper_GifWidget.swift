//
//  Wallpaper_GifWidget.swift
//  Wallpaper-GifWidget
//
//  Created by MAC on 17/11/2023.
//

import WidgetKit
import SwiftUI

struct ProviderLock: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }

    func snapshot(for configuration: ConfigurationLockAppIntent, in context: Context) async -> SimpleEntry {
        WidgetCenter.shared.reloadAllTimelines()
        return SimpleEntry(date: Date(), image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize)
    }
    
    func timeline(for configuration: ConfigurationLockAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        print("DEBUG: goto timeline")
        var imageNames = ["Comp1", "Comp2", "Comp3", "Comp4", "Comp5", "Comp6", "Comp7", "Comp8", "Comp9", "Comp10", "Comp11", "Comp12", "Comp13", "Comp14", "Comp15"
        ]
        if GifWidgetViewModel.shared.playGif {
            var entries: [SimpleEntry] = []
            
            
            let images = imageNames
            
            let count = Int(60 / (Double(imageNames.count) * 0.5))
            
            for _ in 0 ..< count {
                
                
                imageNames.append(contentsOf: images)
            }
            
            let currentDate = Date()
            for (key, name) in imageNames.enumerated() {
                let entryDate = currentDate.addingTimeInterval(Double(key) * 0.5)
                let entry = SimpleEntry(date: entryDate, image: UIImage(named: name)!, size: context.displaySize)
                entries.append(entry)
            }
            
            let reloadDate = currentDate.addingTimeInterval(60)
            return Timeline(entries: entries, policy: .after(reloadDate))
            
        } else {
            
            let entryDate = Date()
            let entry = SimpleEntry(date: entryDate, image: UIImage(named: imageNames.first!)!, size: context.displaySize)
            return Timeline(entries: [entry], policy: .never)
            
        }

    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let size: CGSize
}

struct Wallpaper_GifWidgetEntryView : View {
    var entry: ProviderLock.Entry

    var nameButton: String {
        
        return GifWidgetViewModel.shared.playGif ? "Pause" : "Play"
        
    }
    
    var body: some View {
        VStack {
            Button(intent: PlayButtonIntent(id_name: "haha")) {
                Text("\(nameButton)")
                    .foregroundColor(.red)
            }
            
            Image(uiImage: entry.image)
                .resizable()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
      
        }
    }
}

struct Wallpaper_GifWidget: Widget {
    let kind: String = "Wallpaper_GifWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationLockAppIntent.self, provider: ProviderLock()) { entry in
            Wallpaper_GifWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationLockAppIntent {
    fileprivate static var smiley: ConfigurationLockAppIntent {
        let intent = ConfigurationLockAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationLockAppIntent {
        let intent = ConfigurationLockAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

