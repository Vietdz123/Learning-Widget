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
                                      isDigital: Bool = true,
                                      category: CategoryLock?
    ) -> Timeline<SquareEntry> {
        
        let images = configuration.imageSrc.getImages()
        category?.updateNumberRectImage(number: Double(images.count))

        
        let image = category?.getCurrentImage(images: images) ?? UIImage(named: AssetConstant.imagePlacehodel)!
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
    
    func getProviderIcon(viewModel: SquareViewModel,
                         configuration: LockSquareConfigurationAppIntent,
                         size: CGSize,
                         category: CategoryLock?
    ) -> Timeline<SquareEntry> {
        
        let iconImage = configuration.imageSrc.getIconImage(type: .mainIcon)
        let backgroundImage = configuration.imageSrc.getIconImage(type: .background)
        
        let type = configuration.imageSrc.getLockType()
        
        let entry = SquareEntry(date: .now,
                                image: iconImage,
                                size: size,
                                type: type,
                                imgViewModel: viewModel,
                                imgSrc: configuration.imageSrc,
                                backgroundImage: backgroundImage)
        
        return Timeline(entries: [entry], policy: .never)

    }
    
    func getProviderGif(viewModel: SquareViewModel,
                        configuration: LockSquareConfigurationAppIntent,
                        size: CGSize,
                        category: CategoryLock?
    ) -> Timeline<SquareEntry> {
        
        var durationAnimation: Double = 60
        if UIDevice.current.userInterfaceIdiom == .pad {
            durationAnimation = 30
        }
        var entries: [SquareEntry] = []
        let images = configuration.imageSrc.getImages()
        category?.updateNumberRectImage(number: Double(images.count))
        
        
        let type = configuration.imageSrc.getLockType()
        let delayAnimation = viewModel.category?.delayAnimation ?? 1
        
        let count = Int(durationAnimation / (Double(images.count) * (delayAnimation == 0 ? 1 : delayAnimation))) + 1
        
        
        if type == .placeholder {
            let entry = SquareEntry(date: .now,
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
                let entry = SquareEntry(date: entryDate,
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


