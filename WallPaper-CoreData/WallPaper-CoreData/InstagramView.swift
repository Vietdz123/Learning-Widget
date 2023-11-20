//
//  InstagramView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 20/11/2023.
//

import SwiftUI

struct InstagramView: View {
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                Button(action: {
                    let instagramHooks = "instagram://user"
                    let instagramUrl = URL(string: instagramHooks)
                    if UIApplication.shared.canOpenURL(instagramUrl!) {
                      UIApplication.shared.open(instagramUrl!)
                    } else {
                      //redirect to safari because the user doesn't have Instagram
                      UIApplication.shared.open(URL(string: "http://instagram.com/")!)
                    }
                }, label: {
                    Text("Open instagram")
                })
                
                
                
                
            }
            
            NavigationLink {
                WeatherDayView()
            } label: {
                Text("Next to WeatherDayView")
            }


        }
    }
}

struct WeatherDayView: View {
    var body: some View {
        Text("WeatherDayView")
    }
}

