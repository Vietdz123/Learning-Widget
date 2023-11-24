//
//  LockWidgetView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import WidgetKit
import SwiftUI

struct RectangleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let size: CGSize
    let type: LockType
    let imgViewModel: RectangleViewModel
    let imgSrc: RectSource
}

@available(iOS 17.0, *)
struct RectangleWidgetView : View {
    
    var entry: RectangleEntry

    var body: some View {

        switch entry.type {
        case .gif:
            RectBackgroudView(entry: entry)
        case .quotes:
            RectBackgroudView(entry: entry)
        case .countdown:
            RectBackgroudView(entry: entry)
        case .placeholder:
            LockPlaceHolderView(size: entry.size)
        default:
            EmptyView()
        }

    }
}
