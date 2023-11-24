//
//  LockViewModel.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI


class LockViewModel {
    
    let context = DataController().container.viewContext

    var images: [UIImage] = []
    var currentCheckImageRoutine: [Int] = Array(repeating: 0, count: 7)
    
    var checkedImages: [UIImage] = []
    var currentIndex: Int {
        return Int(category?.currentIndexDigitalFriend ?? 0)
    }
    var category: Category?
    
    var shouldPlaySound: Bool {
        return category?.shouldPlaySound ?? true
    }
    
    func loadData(category: Category?) {
        guard let category = category else { return }
        self.category = category
    }
    
    func toggleShouldPlaySound() {
        category?.shouldPlaySound.toggle()
        CoreDataService.shared.saveContext()
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


class LockWidgetViewModel {
    
    static var shared = LockWidgetViewModel()
    
    var dict: [String: LockViewModel] = [:]
    
}
