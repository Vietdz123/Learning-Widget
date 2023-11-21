//
//  ContentView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                WDNetworkManager.shared.requestApi { _ in
                    print("DEBUG: Done")
                }
            }, label: {
                Text("Load Data")
            })
            
        }
        .padding()

    }

        
}

