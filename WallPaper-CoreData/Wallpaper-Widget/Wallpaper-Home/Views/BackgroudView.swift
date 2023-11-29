//
//  BackgroudView.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation


@available(iOS 17.0, *)
struct BackgroudView: View {
    
    var entry: SourceImageEntry
    @Environment(\.widgetFamily) var family
    
    var is_rect: Bool {
        if family == .accessoryRectangular || family == .systemMedium {
            return true
        } else {
            return false
        }
    }
    
    var digitalType: DigitalFriendType {
        return entry.digitalType
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: entry.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                .transition(.push(from: .bottom))
//                .animation(.spring(duration: 0.2), value: entry.image)
                .ignoresSafeArea()
                
                
            switch digitalType {
            case .changeBackground:
                if entry.imgViewModel.category?.hasSound == true {
                    Button(intent: SoundMakerIntent(id_name: entry.imgSrc.actualName)) {
                        Text("")
                            .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                            .background(Color.clear)
                    }
                    .buttonStyle(.plain)
                } else {
                    Button(intent: ChangeBackgroundIntent(id_name: entry.imgSrc.actualName, is_rect: is_rect)) {
                        Text("")
                            .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                            .background(Color.clear)

                    }
                    .buttonStyle(.plain)
                }
            case let .delayActive(isActive):
                if isActive {
                    if entry.imgViewModel.category?.hasSound == true {
                        Button(intent: SoundMakerIntent(id_name: entry.imgSrc.actualName)) {
                            Text("")
                                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                                .background(Color.clear)
                        }
                        .buttonStyle(.plain)
                    } else {
                        Button(intent: ChangeBackgroundIntent(id_name: entry.imgSrc.actualName, is_rect: is_rect)) {
                            Text("")
                                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                                .background(Color.clear)

                        }
                        .buttonStyle(.plain)
                    }
                }
            }


        }
    }
    

}
