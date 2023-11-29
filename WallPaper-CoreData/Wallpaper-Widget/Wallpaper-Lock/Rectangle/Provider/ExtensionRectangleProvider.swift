//
//  ExtensionProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI
import WidgetKit


extension RectangleProvider {
    
    func getProviderDigitalAndRoutine(viewModel: RectangleViewModel,
                                      configuration: LockRectangleConfigurationAppIntent,
                                      size: CGSize,
                                      isDigital: Bool = true,
                                      category: CategoryLock?
    ) -> Timeline<RectangleEntry
    
    > {
        
        let images = configuration.imageSrc.getImages()
        category?.updateNumberRectImage(number: Double(images.count))

        
        let image = category?.getCurrentImage(images: images) ?? UIImage(named: AssetConstant.imagePlacehodel)!
        let type = configuration.imageSrc.getLockType()
        
        let entry = RectangleEntry(date: .now,
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
    

    
    func getProviderGif(viewModel: RectangleViewModel,
                        configuration: LockRectangleConfigurationAppIntent,
                        size: CGSize,
                        category: CategoryLock?
    ) -> Timeline<RectangleEntry> {
        
        var durationAnimation: Double = 60
        if UIDevice.current.userInterfaceIdiom == .pad {
            durationAnimation = 30
        }
        
        var entries: [RectangleEntry] = []
        let images = configuration.imageSrc.getImages()
        category?.updateNumberRectImage(number: Double(images.count))
        
        
        let type = configuration.imageSrc.getLockType()
        let delayAnimation = viewModel.category?.delayAnimation ?? 1
        
        let count = Int(durationAnimation / (Double(images.count) * (delayAnimation == 0 ? 1 : delayAnimation))) + 1
        print("DEBUG: \(count) count")
        
        if type == .placeholder {
            let entry = RectangleEntry(date: .now,
                                       image: UIImage(named: AssetConstant.imagePlacehodel)!,
                                       size: size,
                                       type: type,
                                       imgViewModel: viewModel,
                                       imgSrc: configuration.imageSrc)
            return Timeline(entries: [entry], policy: .never)
        }
        
        let currentDate = Date()
        let numberImage = images.count
        for i in 0 ..< count {
            for (key, image) in images.enumerated() {
                let entryDate = currentDate.addingTimeInterval(Double(key + i * numberImage) * delayAnimation)
                let entry = RectangleEntry(date: entryDate,
                                           image: image,
                                           size: size,
                                           type: type,
                                           imgViewModel: viewModel,
                                           imgSrc: configuration.imageSrc)
                entries.append(entry)
            }
        }

        
        let reloadDate = currentDate.addingTimeInterval(300)
        return Timeline(entries: entries, policy: .after(reloadDate))

    }
}
