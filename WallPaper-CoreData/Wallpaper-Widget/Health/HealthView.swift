//
//  HealView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 29/11/2023.
//

import SwiftUI
import WidgetKit


struct HealthWidgetView : View {
    var entry: HealthEntry
    
    
    
    var body: some View {
        ZStack {
            
            
            Text(entry.text)
                .foregroundColor(.black)
                .font(.system(size: 25))
            
            
        }
        
    }
}

