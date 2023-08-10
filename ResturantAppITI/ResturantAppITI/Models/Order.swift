//
//  Order.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 05/08/2023.
//

import Foundation
struct Order: Codable {
    var menuItems: [MenuItem]
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}

struct OrderDetails : Codable {
    var id : Int
    var userId : Int
    var Total : Int
    var Status : String
    var CreateAt : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case Total = "total"
        case Status = "status"
        case CreateAt = "createAt"
    }
    
    
}

struct Res : Codable {
    let orders : OrderDetails
}


struct getAllOedResp: Codable {
    let message: String
    var orders : [OrderDetails]
    // You might need to adapt the structure of this based on your backend response format
}
