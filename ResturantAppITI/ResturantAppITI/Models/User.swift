//
//  User.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 09/08/2023.
//

import Foundation


struct User: Codable {
    var id: Int
    var email: String
    var fullname: String
    var createAt: String
    var currentOrderID: Int
   
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case fullname = "fullname"
        case createAt = "createAt"
        case currentOrderID = "current_order_id"
    }
}

struct UserResponse: Codable {
    let user: User
}
