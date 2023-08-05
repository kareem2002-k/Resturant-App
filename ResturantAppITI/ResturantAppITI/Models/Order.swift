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
