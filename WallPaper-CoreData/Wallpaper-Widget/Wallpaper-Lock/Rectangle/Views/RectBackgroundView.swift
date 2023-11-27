//
//  RectBackgroundView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation


@available(iOS 17.0, *)
struct RectBackgroudView: View {
    
    var entry: RectangleEntry
    
    var body: some View {
        ZStack {
            Image(uiImage: entry.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                .ignoresSafeArea()
            
            if entry.imgViewModel.category?.hasSound == true {
                Button(intent: SoundMakerIntent(id_name: entry.imgSrc.actualName)) {
                    Text("")
                        .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                        .background(Color.clear)
                }
                .buttonStyle(.plain)
            } else {
                Button(intent: ChangeBackgroundRectIntent(id_name: entry.imgSrc.actualName, is_rect: true)) {
                    Text("")
                        .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                        .background(Color.clear)

                }
                .buttonStyle(.plain)
            }

        }
    }
    

}
