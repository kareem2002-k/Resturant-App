//
//  OrderResponse.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 05/08/2023.
//

import Foundation
struct OrderResponse: Codable {
    let prepTime: Int
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

