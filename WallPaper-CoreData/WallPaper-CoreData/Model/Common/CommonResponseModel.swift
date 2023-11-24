//
//  CommonModel.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI

struct Thumbnail: Codable {
    let file_name: String
    let key_type: String
    let type_file: String
    let url: PathURL
}

struct WidgetSound: Codable {
    let file_name: String
    let key_type: String
    let type_file: String
    let url: PathURL
}

struct WidgetPath: Codable {
    let file_name: String
    let key_type: String
    let type_file: String
    let url: PathURL
}

struct PathURL: Codable {
    let full: String
    let preview: String
    let small: String
    let extra_small: String
}

struct CategoryWidget: Codable {
    let id: Int
    let name: String
}

struct EztApp: Codable {
    let id: Int
    let name: String
   
}

struct EzTags: Codable {
    let id: Int
    let name: String
    let laravel_through_key: Int
}
