//
//  WallPaper_CoreDataApp.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import AVFoundation

@main
struct WallPaper_CoreDataApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear {
                    let audioSession = AVAudioSession.sharedInstance()
                    do {
                        try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
                        try AVAudioSession.sharedInstance().setActive(true)
                        print("DEBUG: setup success")
                    } catch let error as NSError {
                        print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
                    }
                }
                .onOpenURL { instagramUrl in
                    DispatchQueue.main.async {
                        if UIApplication.shared.canOpenURL(instagramUrl) {
                          UIApplication.shared.open(instagramUrl)
                        } else {
                          //redirect to safari because the user doesn't have Instagram
                          UIApplication.shared.open(URL(string: "http://instagram.com/")!)
                        }
                    }
      
                }
        }
    }
}
