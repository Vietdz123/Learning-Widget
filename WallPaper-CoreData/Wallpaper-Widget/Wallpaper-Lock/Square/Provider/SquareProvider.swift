//
//  SquareProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI
import WidgetKit


struct SquareProvider: AppIntentTimelineProvider {

    
    func placeholder(in context: Context) -> SquareEntry {
        SquareEntry(date: .now, image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize, type: .placeholder, imgViewModel: SquareViewModel(), imgSrc: SquareSource(id: LockType.placeholder.rawValue, actualName: LockType.placeholder.rawValue))
    }

    func snapshot(for configuration: LockSquareConfigurationAppIntent, in context: Context) async -> SquareEntry {
        return SquareEntry(date: .now, image: UIImage(named: AssetConstant.checklistButton)!, size: context.displaySize, type: .placeholder, imgViewModel: SquareViewModel(), imgSrc: SquareSource(id: LockType.placeholder.rawValue, actualName: LockType.placeholder.rawValue))
    }
    
    func timeline(for configuration: LockSquareConfigurationAppIntent, in context: Context) async -> Timeline<SquareEntry> {
        
        let viewModel = SquareWidgetViewModel.shared.dict[configuration.imageSrc.actualName] ?? SquareViewModel()
        
        viewModel.loadData(category: configuration.imageSrc.getCategory())
        viewModel.images = configuration.imageSrc.getImages()
        let entry = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize)
        
        return entry
    }
}

