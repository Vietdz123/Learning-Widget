//
//  WallPaperApp.swift
//  WallPaper
//
//  Created by MAC on 19/10/2023.
//

import SwiftUI
import AVFoundation

@main
struct WallPaperApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .onAppear {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                        print("Playback OK")
                        try AVAudioSession.sharedInstance().setActive(true)
                        print("Session is Active")
                    } catch {
                        print("DEBUG: \(error)")
                    }
                }

        }
    }
}

