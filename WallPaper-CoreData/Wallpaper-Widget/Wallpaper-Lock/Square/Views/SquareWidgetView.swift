//
//  SquareWidgetView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import WidgetKit
import SwiftUI


import WidgetKit
import SwiftUI

struct SquareEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let size: CGSize
    let type: LockType
    let imgViewModel: SquareViewModel
    let imgSrc: SquareSource
    let backgroundImage: UIImage

    init(date: Date, image: UIImage, size: CGSize, type: LockType, imgViewModel: SquareViewModel, imgSrc: SquareSource, backgroundImage: UIImage = UIImage(named: AssetConstant.imagePlacehodel)!) {
        self.date = date
        self.image = image
        self.size = size
        self.type = type
        self.imgViewModel = imgViewModel
        self.imgSrc = imgSrc
        self.backgroundImage = backgroundImage
    }

}

@available(iOS 17.0, *)
struct SquareWidgetView : View {
    
    var entry: SquareEntry

    var body: some View {

        switch entry.type {
        case .gif:
            SquareBackgroundView(entry: entry)
        case .quotes:
            SquareBackgroundView(entry: entry)
        case .countdown:
            SquareBackgroundView(entry: entry)
        case .icon:
            SquareIconView(entry: entry)
        case .placeholder:
            LockPlaceHolderView(size: entry.size)
        default:
            EmptyView()
        }

    }
}
