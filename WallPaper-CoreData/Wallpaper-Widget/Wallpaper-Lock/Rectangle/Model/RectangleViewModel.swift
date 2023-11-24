//
//  LockViewModel.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI


class RectangleViewModel {
    
    let context = DataController().container.viewContext

    var images: [UIImage] = []
    
    var currentIndex: Int {
        return Int(category?.currentIndexDigitalFriend ?? 0)
    }
    var category: CategoryLock?
    
    func loadData(category: CategoryLock?) {
        guard let category = category else { return }
        self.category = category
    }
    
     func updateCurrentIndex()  {
         if images.count <= 0 { return SoundPlayer.shared.updateStatus = .reset }
        
        if currentIndex < images.count - 1 {
            category?.currentIndexDigitalFriend += 1
            SoundPlayer.shared.updateStatus = .plus
            
        } else {
            
            category?.currentIndexDigitalFriend = 0
            SoundPlayer.shared.updateStatus = .reset
        }
         
         CoreDataService.shared.saveContext()
    }
    
    var currentImage: UIImage {
        if self.currentIndex >= images.count  {
            return self.images.count == 0 ? UIImage(named: AssetConstant.imagePlacehodel)! : images[0]
        }
        return self.images.count == 0 ? UIImage(named: AssetConstant.imagePlacehodel)! : images[currentIndex]
    }

    var randomImage: UIImage {
        
        return self.images.count == 0 ? UIImage(named: AssetConstant.imagePlacehodel)! : images.shuffled().first!
        
    }
}


class RectWidgetViewModel {
    
    static var shared = RectWidgetViewModel()
    
    var dict: [String: RectangleViewModel] = [:]
    
}
