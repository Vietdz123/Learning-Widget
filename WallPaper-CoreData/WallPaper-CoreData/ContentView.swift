//
//  ContentView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import AVFoundation
import Photos

struct ContentView: View {
    
    
    var namesHealth = ["Run", "Swim", "Sleep", "Swings"]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                
                Button(action: {
                    WDGifNetworkManager.shared.requestApi { _ in
                        print("DEBUG: Done")
                    }
                }, label: {
                    Text("Load Data Gif")
                        .padding(.bottom, 40)
                })
                
                Button(action: {
                    WDIconNetworkManager.shared.requestApi { _ in
                        print("DEBUG: Done")
                    }
                    
                }, label: {
                    Text("Load Data Icon")
                })
                
                Button(action: {
                    WDHomeNetworkManager.shared.requestApi { _ in
                        print("DEBUG: Done")
                    }
                    
                }, label: {
                    Text("Load Data Home")
                })
                
                
                
            }
            .padding()
            
        }
        
    }
    
    
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
