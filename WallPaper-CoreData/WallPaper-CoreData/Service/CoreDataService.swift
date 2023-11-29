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
    
    //MARK: - Home
    func getAllCategory() -> [Category] {
        let request = Category.fetchRequest()
        
        do {
            let categories = try context.fetch(request)
            return categories
        } catch {
            return []
        }
    }
    

    
    func getSuggestedName(isHome: Bool = true, familyLock: FamilyLock = .rectangle) -> [String] {
        if isHome {
            let categories = getAllCategory()
            
            let names =  categories.map { $0.unwrappedName }
            return names
        } else {
            let categories = getAllLockRectCategory(family: familyLock)
            
            let names =  categories.map { $0.unwrappedName }
            return names
        }

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
        
        let query = NSPredicate(format: "%K == %@", #keyPath(Category.name), name)
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
    
    func getDigitalType(with nameDigital: String) -> DigitalFriendType {
        return DigitalFriendType.getType(name: nameDigital)
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





// MARK: - Lock
extension CoreDataService {
    
    func getAllLockRectCategory(family: FamilyLock) -> [CategoryLock] {
        
        let queryFamily = NSPredicate(format: "%K == %@", #keyPath(CategoryLock.familyType), family.name)
        
        let request: NSFetchRequest<CategoryLock> = CategoryLock.fetchRequest()
        request.predicate = queryFamily
        
        do {
            let categories = try context.fetch(request)
            return categories
        } catch {
            return []
        }
    }
    
    func getSounds(categoryLock: CategoryLock, family: FamilyLock) -> [URL] {
        let items = categoryLock.itemArray
        
        let filterItems = items.filter { item in
            return item.unwrappedFamily == family.name
        }
        
        var urls: [URL] = []
        filterItems.forEach { item in
            guard let url = FileService.shared.readUrls(with: categoryLock.unwrappedName, item: item) else { return }
            urls.append(url)
        }
        
        return urls
    }
    
    func getLockCategory(name: String, family: FamilyLock) -> CategoryLock? {
        
        let queryName = NSPredicate(format: "%K == %@", #keyPath(CategoryLock.name), name)
        let queryFamily = NSPredicate(format: "%K == %@", #keyPath(CategoryLock.familyType), family.name)
        let query = NSCompoundPredicate(andPredicateWithSubpredicates: [queryName, queryFamily])
        
        let request: NSFetchRequest<CategoryLock> = CategoryLock.fetchRequest()
        request.predicate = query
        
        guard let category = try? context.fetch(request).first else { return nil }
        return category
    }
    
    func getLockCategory(name: String) -> CategoryLock? {
        
        let queryName = NSPredicate(format: "%K CONTAINS %@", #keyPath(CategoryLock.name), name)
        
        let request: NSFetchRequest<CategoryLock> = CategoryLock.fetchRequest()
        request.predicate = queryName
        
        guard let category = try? context.fetch(request).first else { return nil }
        return category
    }
    
    func getImages(categoryLock: CategoryLock, family: FamilyLock) -> [UIImage] {
        
        let items = categoryLock.itemArray
        var images: [UIImage] = []
        
        var filterItems = items.filter { item in
            return item.unwrappedFamily == family.name
        }
        
        filterItems = filterItems.sorted { $0.creationDate < $1.creationDate }

        filterItems.forEach { item in
            guard let image = FileService.shared.readImage(with: categoryLock.unwrappedName, item: item) else { return }
            images.append(image)

        }
        
        
        return images
    }
}



// MARK: - Private
extension CoreDataService {
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                print("DEBUG: fatal error \(error.localizedDescription)")
//                fatalError("fatal \(error.localizedDescription)")
                
            }
        }
    }
    
}
