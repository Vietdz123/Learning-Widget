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
        
        print("DEBUG: goto timeline ")
         
        let viewModel = SquareViewModel()
        let cate = configuration.imageSrc.getCategory()
        viewModel.loadData(category: cate)
        var lockType = configuration.imageSrc.getLockType()
        
        switch lockType {
        case .gif:
            let provider = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
            
            return provider
            
        case .quotes:
            let provider = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
            
            return provider
            
        case .inline:
            let provider = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
            
            return provider
            
        case .countdown:
            let provider = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
            
            return provider
            
        case .icon:
            let provider = getProviderIcon(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
            return provider
            
        case .placeholder:
            let provider = getProviderGif(viewModel: viewModel, configuration: configuration, size: context.displaySize, category: cate)
            
            return provider
        }
        
        

        
        
    }
}

