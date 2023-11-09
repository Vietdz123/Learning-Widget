//
//  PlayerController.swift
//  WallPaper
//
//  Created by MAC on 09/11/2023.
//

import SwiftUI
import AVFoundation

struct PlayerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ImageController {
        print("DEBUG: PlayerWrapper makeUIViewController")
        return ImageController()
    }
    
    func updateUIViewController(_ uiViewController: ImageController, context: Context) {
        
    }
    
    
}


class ImageController: UIViewController {
    
    // MARK: - Properties
    let player = AVPlayer()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DEBUG: viewDidLoad ImageController")
        NotificationCenter.default.addObserver(self, selector: #selector(playMusic), name: Notification.Name("NotificationIdentifier"), object: nil)

    }
    
    
    @objc func playMusic() {
        print("DEBUG: play music")
        player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!))
        player.play()
    }
    
    // MARK: - Methods
    
    
    // MARK: - Selectors
    
}

