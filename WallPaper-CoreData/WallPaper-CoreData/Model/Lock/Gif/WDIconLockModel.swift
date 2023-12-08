//
//  WDIconLockModel.swift
//  WallPaper-CoreData
//
//  Created by MAC on 08/12/2023.
//


import SwiftUI


struct EztWidgetIconLockResponse: Codable {
    let data: IconLockWidgetData
}

struct IconLockWidgetData: Codable {
    let data: [EztLockIconWidget]
}

struct EztLockIconWidget: Codable {
    let id: Int
    let icons: [WidgetLockPath]
    let background: [WidgetLockPath]
    let thumbnail: [ThumbnailLock]?
    let order: Int
    let trend: Int
    let set_count: Int
    let daily_rating: Int
    let license: String
    let category_v2_id: Int
    let updated_at: String
    let created_at: String
    let apps: [EztApp]
}

