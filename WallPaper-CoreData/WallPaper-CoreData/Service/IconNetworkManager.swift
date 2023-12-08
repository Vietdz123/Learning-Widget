//
//  IconNetworkManager.swift
//  WallPaper-CoreData
//
//  Created by MAC on 08/12/2023.
//


import SwiftUI


class WDIconNetworkManager {
    let context = CoreDataService.shared.context
    
    static let shared = WDIconNetworkManager()

    func requestApi(completion: @escaping ((Bool) -> Void)) {
        
        guard let url = constructRequest() else { completion(false); return }
        let urlRequest = URLRequest(url: url)
        let dispathGroup = DispatchGroup()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                if error != nil { completion(false); return }
                guard let data = data else { completion(false); return }
                
                do {
                    print("DEBUG: \(String(describing: try? JSONSerialization.jsonObject(with: data))) vlll")
                    let response = try JSONDecoder().decode(EztWidgetIconLockResponse.self, from: data)
       
                    response.data.data.forEach { iconWidget in
                        dispathGroup.enter()
                        self.downloadFileCoreData(data: iconWidget) {
                            dispathGroup.leave()
                        }
                    }
                    
                    dispathGroup.notify(queue: .main) {
                        completion(true)
                    }

                } catch {
                    print("DEBUG: \(error.localizedDescription) fdfds")
                    completion(false)
                }
            }

        }.resume()

    }
    
    private func downloadFileCoreData(data: EztLockIconWidget, completion: @escaping(() -> Void)) {
        let dispathGroup = DispatchGroup()
        let foldername = "\(LockType.icon.rawValue) \(data.id)"
        
        let existCate = CoreDataService.shared.getLockCategory(name: foldername)
        if let existCate = existCate {
            completion()
            return
        }
        
        let category = CategoryLock(context: context)
        
        category.lockType = LockType.icon.rawValue
        category.name = foldername
        category.creationDate = Date().timeIntervalSinceNow
        category.hasSound = false
        category.familyType = FamilyLock.square.name
        
        let widgetPathIcon = data.icons
        let widgetPathBackground = data.background

        for (index, path) in widgetPathIcon.enumerated()  {
                
            dispathGroup.enter()
            
            let item = Item(context: context)
            item.family = FamilyLock.square.name
            item.creationDate = Date().timeIntervalSinceNow + Double(1000 * index)
            item.name = path.file_name
            item.imageType = IconType.mainIcon.rawValue
            
            guard let url = URL(string: path.url.full),
                  let file = FileService.relativePath(with: foldername)?.appendingPathComponent("\(path.file_name)")
            else {  context.reset(); dispathGroup.leave(); completion(); return }
            
            let urlRequest = URLRequest(url: url)

            URLSession.shared.downloadTask(with: urlRequest) { urlResponse, _, error in
                
                if let _ = error { self.context.reset(); dispathGroup.leave(); completion(); return }
                
                guard let urlResponse = urlResponse else  { self.context.reset(); dispathGroup.leave(); completion(); return  }
                
                FileService.shared.writeToSource(with: foldername, with: urlResponse, to: file)
                
                category.addToItems(item)
                self.saveContext()
                
                dispathGroup.leave()
                
            }.resume()
        }
        
        for (index, path) in widgetPathBackground.enumerated()  {
                
            dispathGroup.enter()
            
            let item = Item(context: context)
            item.family = FamilyLock.square.name
            item.creationDate = Date().timeIntervalSinceNow + Double(1000 * index)
            item.name = path.file_name
            item.imageType = IconType.background.rawValue
            
            guard let url = URL(string: path.url.full),
                  let file = FileService.relativePath(with: foldername)?.appendingPathComponent("\(path.file_name)")
            else {  context.reset(); dispathGroup.leave(); completion(); return }
            
            let urlRequest = URLRequest(url: url)

            URLSession.shared.downloadTask(with: urlRequest) { urlResponse, _, error in
                
                if let _ = error { self.context.reset(); dispathGroup.leave(); completion(); return }
                
                guard let urlResponse = urlResponse else  { self.context.reset(); dispathGroup.leave(); completion(); return  }
                
                FileService.shared.writeToSource(with: foldername, with: urlResponse, to: file)
                
                category.addToItems(item)
                self.saveContext()
                
                dispathGroup.leave()
                
            }.resume()
        }
        
        dispathGroup.notify(queue: .main) {
            completion()
        }
        
    }
    

}


extension WDIconNetworkManager {
    
    private func constructRequest() -> URL? {
        
        var components = URLComponents()
        components.scheme = WDNetworkManagerConstant.sheme
        components.host = WDNetworkManagerConstant.host
        components.path = WDNetworkManagerConstant.pathIcon
        components.queryItems = [
            URLQueryItem(name: "with", value: WDNetworkManagerConstant.query),
            URLQueryItem(name: "limit", value: "\(100)"),
//            URLQueryItem(name: "where", value: "active+0"),
//            URLQueryItem(name: "dev", value: "1"),
        ]
        
        return components.url
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                print("DEBUG: error savecontext \(error.localizedDescription)")
                //                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
