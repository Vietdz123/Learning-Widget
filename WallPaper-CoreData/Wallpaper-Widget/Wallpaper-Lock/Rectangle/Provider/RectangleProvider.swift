//
//  LockRectProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//


import WidgetKit
import SwiftUI

struct RectangleProvider: AppIntentTimelineProvider {

    
    func placeholder(in context: Context) -> RectangleEntry {
        RectangleEntry(date: .now, image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize, type: .placeholder, imgViewModel: RectangleViewModel(), imgSrc: RectSource(id: LockType.placeholder.rawValue, actualName: LockType.placeholder.rawValue))
    }

    func snapshot(for configuration: LockRectangleConfigurationAppIntent, in context: Context) async -> RectangleEntry {
        return RectangleEntry(date: .now, image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize, type: .placeholder, imgViewModel: RectangleViewModel(), imgSrc: RectSource(id: LockType.placeholder.rawValue, actualName: LockType.placeholder.rawValue))
    }
    
    func timeline(for configuration: LockRectangleConfigurationAppIntent, in context: Context) async -> Timeline<RectangleEntry> {
        
        print("DEBUG: goto timeline ")
         
        let viewModel = RectangleViewModel()
        let cate = configuration.imageSrc.getCategory()
        viewModel.loadData(category: cate)

        let provider = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
        return provider
    }
}

