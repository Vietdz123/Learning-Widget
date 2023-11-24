//
//  CoreDataService.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import CoreData

class CoreDataService {
    
    let context = DataController().container.viewContext
    
    static let shared = CoreDataService()
    
    func getAllCategory() -> [Category] {
        let request = Category.fetchRequest()
        
        do {
            let categories = try context.fetch(request)
            return categories
        } catch {
            return []
        }
    }
    
    func getSuggestedName() -> [String] {
        let categories = getAllCategory()
        
        let names =  categories.map { $0.unwrappedName }
        return names
    }
    
    func getImages(category: Category, family: FamilyHome) -> [UIImage] {
        
        let items = category.itemArray
        var images: [UIImage] = []
        
        var filterItems = items.filter { item in
            return item.unwrappedFamily == family.rawValue
        }
        
        filterItems = filterItems.sorted { $0.creationDate < $1.creationDate }

        filterItems.forEach { item in
            guard let image = FileService.shared.readImage(with: category.unwrappedName, item: item) else { return }
            images.append(image)

        }
        
        
        return images
    }
    
    
    func getCategory(name: String) -> Category? {
        
        let query = NSPredicate(format: "%K CONTAINS %@", #keyPath(Category.name), name)
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = query
        
        guard let category = try? context.fetch(request).first else { return nil }
        return category
        
    }
    
    func getFolderType(with nameFolder: String) -> WDHomeFolderType {
        return WDHomeFolderType.getType(name: nameFolder)
    }
    
    func getRoutineType(with nameRoutine: String) -> RoutinMonitorType {
        return RoutinMonitorType.getType(name: nameRoutine)
    }
    
    func getSoundType(with nameSound: String) -> SoundType {
        return SoundType.getType(name: nameSound)
    }
    
    func getSounds(category: Category, family: FamilyHome) -> [URL] {
        let items = category.itemArray
        
        let filterItems = items.filter { item in
            return item.unwrappedFamily == family.rawValue
        }
        
        var urls: [URL] = []
        filterItems.forEach { item in
            guard let url = FileService.shared.readUrls(with: category.unwrappedName, item: item) else { return }
            urls.append(url)
        }
        
        return urls
    }
    
    func getButtonCheckListModel(category: Category) -> ButtonCheckListModel {
        
        let items = category.itemArray
        
        let checkItems = items.filter { item in
            return item.unwrappedFamily == FamilyHome.check.rawValue
        }
        
        let uncheckItems = items.filter { item in
            return item.unwrappedFamily == FamilyHome.uncheck.rawValue
        }
        
        var checkImages: [UIImage] = []
        var uncheckImages: [UIImage] = []
        
        checkItems.forEach { item in
            guard let image = FileService.shared.readImage(with: category.unwrappedName, item: item) else { return }
            checkImages.append(image)
        }
        
        uncheckItems.forEach { item in
            guard let image = FileService.shared.readImage(with: category.unwrappedName, item: item) else { return }
            uncheckImages.append(image)
        }
        
        return ButtonCheckListModel(checkImage: checkImages, uncheckImage: uncheckImages)
    }

}


extension CoreDataService {
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                print("DEBUG: fatal error \(nserror.localizedDescription)")
                fatalError("Error CoreData saveContext")
                
            }
        }
    }
    
}
