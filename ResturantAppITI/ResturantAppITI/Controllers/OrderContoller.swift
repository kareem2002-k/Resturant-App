//
//  OrderContoller.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 09/08/2023.
//

import Foundation
import Alamofire

class OrderController {
    static let shared = OrderController()
    
    func CreateOrder(authtoken : String,completion: @escaping (Bool) -> Void) {
        // Prepare your order data
        let products: [MenuItem] = MenuController.shared.order.menuItems
        
        // Convert the array of structs into an array of dictionaries
        let productDictionaries: [[String: Any]] = products.map { product in
            return [
                "product_id": product.id,
                "price": product.price,
                "category": product.category,
                "name": product.name,
                // Add other fields as needed
            ]
        }
        
        let orderData: [String: Any] = [
            "products": productDictionaries
            // Add other order data if needed
        ]
        
        // Define the API endpoint URL
        let apiUrl = "http://localhost:8000/order" // Replace with your actual API URL
        
        
        // Define the headers with the authentication token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authtoken)"
        ]
        
        // Send the order data to the backend with the headers
        AF.request(apiUrl, method: .post, parameters: orderData, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.value as? [String: Any],
                       let message = value["message"] as? String {
                        print("Order created successfully: \(message)")
                        completion(true)
                        MenuController.shared.order.menuItems = []
                        // Handle success response here
                    }
                case .failure(let error):
                    print("Error creating order: \(error)")
                    // Handle error response here
                    completion(false)
                }
            }

    }

    
}
