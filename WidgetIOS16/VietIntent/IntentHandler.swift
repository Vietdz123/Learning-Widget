//
//  IntentHandler.swift
//  VietIntent
//
//  Created by MAC on 24/04/2024.
//

import Intents

class IntentHandler: INExtension, SelectCategoryIntentHandling {
    
    func provideVietNameOptionsCollection(for intent: SelectCategoryIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        completion(INObjectCollection(items: ["place holder", "snapshot", "viet", "long", "duc anh"]), nil)
    }

    
   
    func resolveVietName(for intent: SelectCategoryIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
    }

    override func handler(for intent: INIntent) -> Any {
        return self
    }

}
