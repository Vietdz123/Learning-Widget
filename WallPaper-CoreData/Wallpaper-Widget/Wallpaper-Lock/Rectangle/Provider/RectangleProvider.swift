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
        
        let viewModel = RectWidgetViewModel.shared.dict[configuration.imageSrc.actualName] ?? RectangleViewModel()
        
        viewModel.loadData(category: configuration.imageSrc.getCategory())
        viewModel.images = configuration.imageSrc.getImages()
        let entry = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize)
        
        return entry
    }
}

