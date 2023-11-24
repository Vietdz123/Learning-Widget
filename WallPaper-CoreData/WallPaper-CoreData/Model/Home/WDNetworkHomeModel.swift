//
//  WDNetworkModel.swift
//  WallPaper
//
//  Created by MAC on 26/10/2023.
//

import SwiftUI


struct EztWidgetHomeResponse: Codable {
    let data: HomeWidgetData
}

struct HomeWidgetData: Codable {
    let data: [EztWidget]
}

struct EztWidget: Codable {
    let id: Int
    let thumbnail: [Thumbnail]?
    let sound: [WidgetSound]?
    let path: [WidgetPath]
    let category_id: Int
    let is_trend: Int
    let is_private: Int
    let order: Int
    let delay_animation: Int
    let active: Int
    let download: Int
    let rating: Int
    let daily_rating: Int
    let set: Int
    let cost: Int
    let license: String
    let updated_at: String
    let created_at: String
    let category: CategoryWidget
    let apps: [EztApp]
    let tags: [EzTags]
}
