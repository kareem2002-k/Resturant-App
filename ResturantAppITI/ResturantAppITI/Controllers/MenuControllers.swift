//
//  MenuControllers.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 05/08/2023.
//

import Foundation
class MenuController {
    
    static let orderUpdatedNotification =
       Notification.Name("MenuController.orderUpdated")

    
    static let shared = MenuController()
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name:
               MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
   
  
    let baseURL = URL(string: "http://localhost:8080/")!
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
        
    }
   
    struct CategoriesResponse: Codable {
        let categories: [String]
    }

    func fetchCategories() async throws -> [String] {
        let categoriesURL = baseURL.appendingPathComponent("categories")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: categoriesURL)
            
            // Check the response status
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Response: \(response)")
                throw MenuControllerError.categoriesNotFound
            }
            
            // Parse the JSON response data to get categories
            let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            let categories = categoriesResponse.categories
            return categories
        } catch {
            print("Error fetching categories: \(error)")
            throw MenuControllerError.categoriesNotFound
        }
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
 
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }
        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)
        return menuResponse.items
          
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
           guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
               throw MenuControllerError.orderRequestFailed
           }
           let decoder = JSONDecoder()
           let orderResponse = try decoder.decode(OrderResponse.self, from: data)
           return orderResponse.prepTime
          
    }

   
   

   
}
