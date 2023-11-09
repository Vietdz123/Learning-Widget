//
//  SourceMakerIntent.swift
//  WallPaper
//
//  Created by MAC on 09/11/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation

//@available(iOSApplicationExtension, unavailable)
//extension SoundMakerIntent: ForegroundContinuableIntent { }

struct SoundMakerIntent: AudioPlaybackIntent {
    static var title: LocalizedStringResource = "Play a sound"
    static var description: IntentDescription = IntentDescription("Plays a widget sound")
    
    init() {}
    
    @Parameter(title: "Task ID")
    var id_name: String
    
    init(id_name: String) {
        self.id_name = id_name
    }
    
    func perform() async throws -> some IntentResult {
        print("DEBUG: goto SoundMakerIntent")
        
//        WidgetViewModel.shared.dict[id_name]?.updateCurrentIndex()
//        SoundPlayer.shared.name = id_name
        SoundPlayer.shared.play()
        
        return .result()
    }
}

class SoundPlayer: NSObject {
    static let shared = SoundPlayer()
    
    var name: String = ""
//    private var player: AVAudioPlayer?
     var player: AVPlayer = AVPlayer()
    
    func play() {
        print("DEBUG: siuuuu")
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try? AVAudioSession.sharedInstance().setActive(true)

        
//        guard let player = try? AVAudioPlayer(contentsOf: URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!) else { print("DEBUG: return cmnr"); return }
        print("DEBUG: goto play")
        player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!))
//        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
//        WidgetViewModel.shared.dict[name]?.updateCurrentIndex()
        player.play()
        
    }
}
