//
//  File.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI


struct LockPlaceHolderView: View {
    
    var size: CGSize
    
    var body: some View {
        ZStack {
                
            Image("sasuke")
                .resizable()
                .renderingMode(.original)
                .frame(width: 50, height: 50)
            
        }
    }
}

