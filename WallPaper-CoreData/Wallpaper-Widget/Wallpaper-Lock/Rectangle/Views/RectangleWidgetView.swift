//
//  LockWidgetView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import WidgetKit
import SwiftUI

struct RectangleWidgetView : View {
    var entry: RectangleProvider.Entry


    
    var body: some View {
        ZStack {

            
            Image(uiImage: entry.image)
                .resizable()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
            

        }

    }
}
