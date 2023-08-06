//
//  MenuControllers.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 05/08/2023.
//

import Foundation
class MenuController {
    
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json",
       forHTTPHeaderField: "Content-Type")
    

    
    
    let baseURL = URL(string: "http://localhost:8080/")!
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
    }
   
    
    func fetchCategories() async throws -> [String] {
        let categoriesURL = baseURL.appendingPathComponent("categories")
        let (data, response) = try await URLSession.shared.data(from:
           categoriesURL)
    }
     
   
    
    func fetchMenuItems(forCategory categoryName: String) async throws ->
       [MenuItem] {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL,
           resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category",
           value: categoryName)]
        let menuURL = components.url!
        let (data, response) = try await URLSession.shared.data(from:
           menuURL)
    }
   
    
    typealias MinutesToPrepare = Int
     
    
    func submitOrder(forMenuIDs menuIDs: [Int]) async throws ->
       MinutesToPrepare {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:
           "Content-Type")
     
        let menuIdsDict = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(menuIdsDict)
        request.httpBody = jsonData
     
        let (data, response) = try await URLSession.shared.data(for:
           request)
    }

   
   

   
}
