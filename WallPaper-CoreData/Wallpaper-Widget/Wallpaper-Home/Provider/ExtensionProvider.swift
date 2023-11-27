//
//  ExtensionProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 21/11/2023.
//

import SwiftUI
import WidgetKit
import UIKit


extension HomeProvider {
    
    func getProviderDigitalAndRoutine(viewModel: ImageDataViewModel,
                                      configuration: ConfigurationAppIntent,
                                      size: CGSize,
                                      isDigital: Bool = true,
                                      family: WidgetFamily,
                                      category: Category?
    ) -> Timeline<SourceImageEntry> {
        
        var images: [UIImage] = []
        switch family {
        case .systemSmall, .systemLarge:
            images = configuration.imageSrc.getImages(family: .square)
            category?.updateNumberSquareImage(number: Double(images.count))
        case .systemMedium:
            images = configuration.imageSrc.getImages(family: .rectangle)
            category?.updateNumberRectImage(number: Double(images.count))
        default:
            images = []
        }
        
        let image = category?.getCurrentImage(images: images) ?? UIImage(named: AssetConstant.imagePlacehodel)!
        let type = configuration.imageSrc.getFolderType()
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        category?.updateNumberCheckedImage(number: Double(btnCLModel.checkImage.count))
        
        let entry = SourceImageEntry(date: .now,
                                    image: image,
                                    size: size,
                                    type: type,
                                    btnChecklistModel: btnCLModel,
                                    imgViewModel: viewModel,
                                    imgSrc: configuration.imageSrc,
                                    routineType: routineType)
        
        if isDigital {
            return Timeline(entries: [entry], policy: .never)
        } else {
            return Timeline(entries: [entry], policy: .never)
        }
    }
    
    func getProviderSounds(viewModel: ImageDataViewModel,
                           configuration: ConfigurationAppIntent,
                           size: CGSize,
                           family: WidgetFamily,
                           category: Category?
    ) -> Timeline<SourceImageEntry> {
        
        var entries: [SourceImageEntry] = []
        let image: UIImage
        
        let soundType = configuration.imageSrc.getSoundType()
        var images: [UIImage] = []
        switch family {
        case .systemSmall, .systemLarge:
            images = configuration.imageSrc.getImages(family: .square)
            category?.updateNumberSquareImage(number: Double(images.count))
        case .systemMedium:
            images = configuration.imageSrc.getImages(family: .rectangle)
            category?.updateNumberRectImage(number: Double(images.count))
        default:
            images = []
        }
        
        switch soundType {
        case .circle:
            category?.updateCurrentIndex(isRect: family == .accessoryRectangular || family == .systemMedium)
            image = category?.getCurrentImage(images: images) ?? UIImage(named: AssetConstant.imagePlacehodel)!
        case .makeDesicion:
            image = category?.getRandomImage(images: images) ?? UIImage(named: AssetConstant.imagePlacehodel)!
        }
        
        
        let type = configuration.imageSrc.getFolderType()
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        let dalayAnimation = category?.delayAnimation ?? 1
        
        let firstEntry = SourceImageEntry(date: .now,
                                          image: image,
                                          size: size,
                                          type: type,
                                          btnChecklistModel: btnCLModel,
                                          imgViewModel: viewModel,
                                          imgSrc: configuration.imageSrc,
                                          routineType: routineType)
        entries.append(firstEntry)
        
        
        if soundType == .circle {
            var count: Double = 1
            
            while category?.isFirstImage == false {
                category?.updateCurrentIndex()
                count += 1
                
                let entryDate = Date().addingTimeInterval(dalayAnimation * count)
                let image = category?.getCurrentImage(images: images) ?? UIImage(named: AssetConstant.imagePlacehodel)!
                let entry = SourceImageEntry(date: entryDate,
                                              image: image,
                                              size: size,
                                              type: type,
                                              btnChecklistModel: btnCLModel,
                                              imgViewModel: viewModel,
                                              imgSrc: configuration.imageSrc,
                                              routineType: routineType)
                
                entries.append(entry)
            }
        }
        
        return Timeline(entries: entries, policy: .never)
    }
    
    func getProviderGif(viewModel: ImageDataViewModel,
                        configuration: ConfigurationAppIntent,
                        size: CGSize,
                        family: WidgetFamily,
                        category: Category?
    ) -> Timeline<SourceImageEntry> {
        
        let durationAmination: Double = 300
        var entries: [SourceImageEntry] = []
        var images: [UIImage] = []
        switch family {
        case .systemSmall, .systemLarge:
            images = configuration.imageSrc.getImages(family: .square)
            category?.updateNumberSquareImage(number: Double(images.count))
        case .systemMedium:
            images = configuration.imageSrc.getImages(family: .rectangle)
            category?.updateNumberRectImage(number: Double(images.count))
        default:
            images = []
        }
        
        
        let type = configuration.imageSrc.getFolderType()
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        
        let delayAnimation = viewModel.category?.delayAnimation ?? 1
        
        let count = Int(durationAmination / (Double(images.count) * (delayAnimation == 0 ? 1 : delayAnimation))) + 1
        
        
        if type == .placeholder {
            let entry = SourceImageEntry(date: .now,
                                         image: images.first ?? UIImage(named: AssetConstant.imagePlacehodel)!,
                                         size: size,
                                         type: type,
                                         btnChecklistModel: btnCLModel,
                                         imgViewModel: viewModel,
                                         imgSrc: configuration.imageSrc,
                                         routineType: routineType)
            return Timeline(entries: [entry], policy: .never)
        }
        
        let currentDate = Date()
        let numberImage = images.count
        for i in 0 ..< count {
            for (key, image) in images.enumerated() {
                let entryDate = currentDate.addingTimeInterval(Double(key + i * numberImage) * delayAnimation)
                let entry = SourceImageEntry(date: entryDate,
                                             image: image,
                                             size: size,
                                             type: type,
                                             btnChecklistModel: btnCLModel,
                                             imgViewModel: viewModel,
                                             imgSrc: configuration.imageSrc,
                                             routineType: routineType)
                entries.append(entry)
            }
        }

        
        let reloadDate = currentDate.addingTimeInterval(durationAmination)
        return Timeline(entries: entries, policy: .after(reloadDate))

    }
}
