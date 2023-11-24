//
//  ChangeBackgroundRectIntent.swift
//  Wallpaper-WidgetExtension
//
//  Created by MAC on 24/11/2023.
//


import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation

struct ChangeBackgroundRectIntent: AppIntent {
    

    init() {
        
    }
    
    static var title: LocalizedStringResource = "ChangeBackgroundSquareIntent"
    
    @Parameter(title: "Task ID")
    var id_name: String
    
    init(id_name: String) {
        self.id_name = id_name
    }
    
    func perform() async throws -> some IntentResult {
        
        RectWidgetViewModel.shared.dict[id_name]?.updateCurrentIndex()
        
        return .result()
    }
    
}


