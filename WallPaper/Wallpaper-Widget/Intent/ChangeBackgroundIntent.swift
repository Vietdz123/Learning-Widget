//
//  ToggleButtonIntent.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation


//@available(iOSApplicationExtension, unavailable)
//extension ChangeBackgroundIntent: ForegroundContinuableIntent { }


struct ChangeBackgroundIntent: AppIntent {
    

    init() {
        
    }
    
    static var title: LocalizedStringResource = "ButtonAppIntent"
    
    @Parameter(title: "Task ID")
    var id_name: String
    
    init(id_name: String) {
        self.id_name = id_name
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {

//        print("DEBUG: push notifi")
//        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        print("DEBUG: goto ChangeBackgroundIntent")
        WidgetViewModel.shared.dict[id_name]?.updateCurrentIndex()
        return .result()
    }
    
}
