//
//  AppEntity+Query.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//


import WidgetKit
import AppIntents
import SwiftUI

struct RectSource: AppEntity {
    
    var id: String
    var actualName: String
    
    static var defaultQuery: RectQuery = RectQuery()
    
    func getCategory() -> CategoryLock? {
        return CoreDataService.shared.getLockCategory(name: actualName, family: .rectangle)
    }
    
    static var defaultValue: RectSource {
        return RectSource(id: "choose", actualName: LockType.placeholder.rawValue)
    }
    
    func getSoundUrls() -> [URL] {
        guard let cate = getCategory() else { return [] }
        
        return CoreDataService.shared.getSounds(categoryLock: cate, family: .rectangle)
    }
    
         
    func getImages() -> [UIImage] {
        guard let cate = getCategory() else { return [UIImage(named: AssetConstant.imagePlacehodel)!] }
        let images = CoreDataService.shared.getImages(categoryLock: cate, family: .rectangle)
        
        return images
    }
    
    func getLockType() -> LockType {
        guard let cate = getCategory() else { return .placeholder }
        
        return LockType(rawValue: cate.unwrappedLockType) ?? .placeholder
    }
    
    static func getSuggested() -> [RectSource] {
        
        return CoreDataService.shared.getSuggestedName(isHome: false, familyLock: .rectangle).map { name in
            return RectSource(id: name, actualName: name)
        }
    }
    
    static func getAllSource() -> [RectSource] {
        var src = getSuggested()
        src.append(RectSource.defaultValue)
        return src
    }
    
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Image Viet"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
}

struct RectQuery: EntityStringQuery {
    
    func entities(matching string: String) async throws -> [RectSource] {
        return RectSource.getAllSource().filter { imgsrc in
            return imgsrc.id == string
        }
    }
    
    
    func entities(for identifiers: [ImageSource.ID]) async throws -> [RectSource] {
   
        let imgs = RectSource.getAllSource().filter { imgsrc in
            return identifiers.contains { id in
                return id == imgsrc.id
            }
        }
        
        if imgs.count > 0 && RectWidgetViewModel.shared.dict[imgs[0].actualName] == nil {
            if let cate = CoreDataService.shared.getLockCategory(name: imgs[0].actualName)  {
                let name = cate.unwrappedName
                RectWidgetViewModel.shared.dict[name] = RectangleViewModel()
            }
        }
        
        if imgs.count > 0 {
            return [imgs[0]]
        } else {
            return []
        }
        
    }
    
    func suggestedEntities() async throws -> [RectSource] {
        return RectSource.getSuggested()
    }
    
    func defaultResult() async -> RectSource? {
        return RectSource.defaultValue
    }
}

