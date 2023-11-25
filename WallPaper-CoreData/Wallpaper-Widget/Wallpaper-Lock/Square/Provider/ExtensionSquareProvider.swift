//
//  ExtensionProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI
import WidgetKit


extension SquareProvider {
    
    func getProviderDigitalAndRoutine(viewModel: SquareViewModel,
                                      configuration: LockSquareConfigurationAppIntent,
                                      size: CGSize,
                                      isDigital: Bool = true
    ) -> Timeline<SquareEntry> {
        
        let image = viewModel.currentImage
        let type = configuration.imageSrc.getLockType()
        
        let entry = SquareEntry(date: .now,
                                   image: image,
                                   size: size,
                                   type: type,
                                   imgViewModel: viewModel,
                                   imgSrc: configuration.imageSrc)
        
        if isDigital {
            return Timeline(entries: [entry], policy: .never)
        } else {
            return Timeline(entries: [entry], policy: .never)
        }
    }
    
    
    
    func getProviderGif(viewModel: SquareViewModel,
                        configuration: LockSquareConfigurationAppIntent,
                        size: CGSize
    ) -> Timeline<SquareEntry> {
        
        var entries: [SquareEntry] = []
    
        let type = configuration.imageSrc.getLockType()
        let images = viewModel.images
        
        var imageForTimeline: [UIImage] = []
        let delayAnimation = viewModel.category?.delayAnimation ?? 1
        
        let count = Int(600 / (Double(images.count) * (delayAnimation == 0 ? 1 : delayAnimation))) + 1
        
        for _ in 0 ..< count {
            imageForTimeline.append(contentsOf: images)
        }
        print("DEBUG: \(count) count and \(type) and \(images.count)")
        
        if type == .placeholder {
            let entry = SquareEntry(date: .now,
                                       image: imageForTimeline.first ?? UIImage(named: AssetConstant.imagePlacehodel)!,
                                       size: size,
                                       type: type,
                                       imgViewModel: viewModel,
                                       imgSrc: configuration.imageSrc)
            return Timeline(entries: [entry], policy: .atEnd)
        }
        
        let currentDate = Date()
        for (key, image) in imageForTimeline.enumerated() {
            let entryDate = currentDate.addingTimeInterval(Double(key) * delayAnimation)
            let entry = SquareEntry(date: entryDate,
                                       image: image,
                                       size: size,
                                       type: type,
                                       imgViewModel: viewModel,
                                       imgSrc: configuration.imageSrc)
            entries.append(entry)
        }
        
        let reloadDate = currentDate.addingTimeInterval(600)
        return Timeline(entries: entries, policy: .after(reloadDate))

    }
}
