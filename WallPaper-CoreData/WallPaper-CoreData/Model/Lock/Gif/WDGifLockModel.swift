//
//  WDGifModel.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI


struct EztWidgetGifLockResponse: Codable {
    let data: GifLockWidgetData
}

struct GifLockWidgetData: Codable {
    let data: [EztLockGifWidget]
}

struct EztLockGifWidget: Codable {
    let id: Int
    let thumbnail: [ThumbnailLock]?
//    let sound: [WidgetSound]?
    let file: [WidgetLockPath]
    let type: Int
    let order: Int
    let delay_animation: Int
    let trend: Int
    let set_count: Int
    let daily_rating: Int
    let license: String
    let category_v2_id: Int
    let updated_at: String
    let created_at: String
    let apps: [EztApp]
}


struct WidgetLockPath: Codable {
    let file_name: String
    let url: PathURL
}

struct ThumbnailLock: Codable {
    let file_name: String
    let type_file: String
    let url: PathURL
}
