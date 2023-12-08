//
//  AppEntity+Query.swift
//  Wallpaper-WidgetExtension
//
//  Created by MAC on 24/11/2023.
//

import Foundation


import WidgetKit
import AppIntents
import SwiftUI

struct SquareSource: AppEntity {
    
    var id: String
    var actualName: String
    
    static var defaultQuery: SquareQuery = SquareQuery()
    
    func getCategory() -> CategoryLock? {
        return CoreDataService.shared.getLockCategory(name: actualName, family: .square)
    }
    
    static var defaultValue: SquareSource {
        return SquareSource(id: "choose", actualName: LockType.placeholder.rawValue)
    }
    
    func getSoundUrls() -> [URL] {
        guard let cate = getCategory() else { return [] }
        
        return CoreDataService.shared.getSounds(categoryLock: cate, family: .square)
    }
    
         
    func getImages() -> [UIImage] {
        guard let cate = getCategory() else { return [UIImage(named: AssetConstant.imagePlacehodel)!] }
        let images = CoreDataService.shared.getImages(categoryLock: cate, family: .square)
        
        return images
    }
    
    func getLockType() -> LockType {
        guard let cate = getCategory() else { return .placeholder }
        
        return LockType(rawValue: cate.unwrappedLockType) ?? .placeholder
    }
    
    static func getSuggested() -> [SquareSource] {
        
        return CoreDataService.shared.getSuggestedName(isHome: false, familyLock: .square).map { name in
            return SquareSource(id: name, actualName: name)
        }
    }
    
    static func getAllSource() -> [SquareSource] {
        var src = getSuggested()
        src.append(SquareSource.defaultValue)
        return src
    }
    
    func getIconImage(type: IconType) -> UIImage {
        guard let cate = getCategory() else { return UIImage(named: AssetConstant.imagePlacehodel)! }
        
        return CoreDataService.shared.getIconImage(categoryLock: cate, type: type)
        
    }
    
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Image Viet"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
}

struct SquareQuery: EntityStringQuery {
    
    func entities(matching string: String) async throws -> [SquareSource] {
        let srcs = SquareSource.getAllSource().filter { imgsrc in
            return imgsrc.id == string
        }
        print("DEBUG: \(srcs.count) entitiesa")
        
        return srcs
    }
    
    
    func entities(for identifiers: [ImageSource.ID]) async throws -> [SquareSource] {
   
        let imgs = SquareSource.getAllSource().filter { imgsrc in
            return identifiers.contains { id in
                return id == imgsrc.id
            }
        }
        
        if imgs.count > 0 {
            return [imgs[0]]
        } else {
            return []
        }
        
    }
    
    func suggestedEntities() async throws -> [SquareSource] {
        return SquareSource.getSuggested()
    }
    
    func defaultResult() async -> SquareSource? {
        return SquareSource.defaultValue
    }
}

