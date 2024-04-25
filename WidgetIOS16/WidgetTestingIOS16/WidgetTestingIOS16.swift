//
//  WidgetTestingIOS16.swift
//  WidgetTestingIOS16
//
//  Created by MAC on 24/04/2024.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), name: "place holder")
    }

    func getSnapshot(for configuration: SelectCategoryIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), name: "snapshot"))
    }
    
    func getTimeline(for configuration: SelectCategoryIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {

        let entry = SimpleEntry(date: .now, name: configuration.vietName ?? "")
        

        completion(Timeline(entries: [entry], policy: .atEnd))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let name: String
}

struct WidgetTestingIOS16EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.name)
        }
    }
}

struct WidgetTestingIOS16: Widget {
    let kind: String = "WidgetTestingIOS16"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                              intent: SelectCategoryIntent.self,
                              provider: Provider(),
                              content: { entry in
                                WidgetTestingIOS16EntryView(entry: entry)
                                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                                  .background(Color.white)
                              })
              .configurationDisplayName("My Widget")
              .description("This is an example widget.")
              .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

