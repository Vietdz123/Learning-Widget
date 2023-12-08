//
//  SquareIconView.swift
//  Wallpaper-WidgetExtension
//
//  Created by MAC on 08/12/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation

struct SquareIconView: View {
    
    var entry: SquareEntry
    
    var body: some View {
        ZStack(alignment: .center) {
            
            Image(uiImage: entry.image.withRenderingMode(.alwaysOriginal))
                .resizable()
                .cornerRadius(entry.size.width / 2)


        }
        .cornerRadius(entry.size.width / 2)
        .containerBackground(for: .widget) {
            Color.yellow
        }
    }
}

