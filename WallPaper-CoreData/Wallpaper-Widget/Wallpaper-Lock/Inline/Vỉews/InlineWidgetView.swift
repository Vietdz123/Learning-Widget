//
//  InlineWidgetView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//


import WidgetKit
import SwiftUI

struct InlineWidgetView : View {
    var entry: InlineProvider.Entry


    
    var body: some View {
        ZStack {

            
            Image(uiImage: entry.image)
                .resizable()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
            

        }

    }
}
