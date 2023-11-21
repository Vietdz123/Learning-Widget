//
//  ExtensionProvider.swift
//  WallPaper-CoreData
//
//  Created by MAC on 21/11/2023.
//

import SwiftUI
import WidgetKit
import UIKit


extension Provider {
    
    func getProviderDigitalAndRoutine(viewModel: ImageDataViewModel,
                                      configuration: ConfigurationAppIntent,
                                      size: CGSize,
                                      isDigital: Bool = true
    ) -> Timeline<SourceImageEntry> {
        
        let image = viewModel.currentImage
        let type = configuration.imageSrc.getFolderType()
        let size = size
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        WidgetViewModel.shared.dict[configuration.imageSrc.actualName]?.checkedImages = btnCLModel.checkImage
        
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
                                      size: CGSize
    ) -> Timeline<SourceImageEntry> {
        
        var entries: [SourceImageEntry] = []
        let image: UIImage
        
        let soundType = configuration.imageSrc.getSoundType()
        
        switch soundType {
        case .circle:
            viewModel.updateCurrentIndex()
            image = viewModel.currentImage
        case .makeDesicion:
            image = viewModel.randomImage
        case .twoImage:
            viewModel.updateCurrentIndex()
            image = viewModel.currentImage
        }
        
        
        let type = configuration.imageSrc.getFolderType()
        let size = size
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        
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
            while SoundPlayer.shared.updateStatus == .plus {
                viewModel.updateCurrentIndex()
                
                let entryDate = Date().addingTimeInterval(0.15)
                let image = viewModel.currentImage
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
                        size: CGSize
    ) -> Timeline<SourceImageEntry> {
        
        var entries: [SourceImageEntry] = []
        
        let image = viewModel.currentImage
        let type = configuration.imageSrc.getFolderType()
        let size = size
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        
        var images = viewModel.images
        let delayAnimation = viewModel.category?.delayAnimation ?? 1
        
        let count = Int(60 / (Double(images.count) * delayAnimation)) - 1
        
        for _ in 0 ..< count {
            images.append(contentsOf: images)
        }
        
        let currentDate = Date()
        for (key, image) in images.enumerated() {
            let entryDate = currentDate.addingTimeInterval(Double(key) * delayAnimation)
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
        
        let reloadDate = currentDate.addingTimeInterval(60)
        return Timeline(entries: entries, policy: .after(reloadDate))

    }
}
