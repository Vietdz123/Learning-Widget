//
//  ContentView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    
    var namesHealth = ["Run", "Swim", "Sleep", "Swings"]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Button(action: {
                    
                    WDGifNetworkManager.shared.requestApi { _ in
                        print("DEBUG: Done")
                    }
                }, label: {
                    Text("Load Data Lock")
                        .padding(.bottom, 40)
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
            
            ForEach(namesHealth, id: \.self) { name in
                Button(action: {
                    CoreDataService.shared.saveHealthItem(name: name)
                }, label: {
                    Text("\(name)")
                })
            }
        }

    }

        
}

