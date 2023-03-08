//
//  PicListResponse.swift
//  StoreLab
//
//  Created by tzh on 08/03/2023.
//

import Foundation
struct Picture: Codable {
    let id, author: String?
    let width, height: Int
    let url, downloadURL: String?

     var  isFav: Bool = false
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias PicListResponse = [Picture]
