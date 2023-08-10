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
    
    var orderDetail : OrderDetails!
    
    var ClientAllOrders : [OrderDetails]!
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
    
    
    func GetCurrentOrder(authtoken : String ,completion: @escaping (Bool) -> Void) {
        // Define the API endpoint URL
        let apiUrl = "http://localhost:8000/currentorder" // Replace with your actual API URL
        
        // Define the headers with the authentication token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authtoken)"
        ]
        
        // Make the GET request
        AF.request(apiUrl, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let responseData = response.data {
                        do {
                            let orderres = try JSONDecoder().decode(Res.self, from: responseData)
                            self.orderDetail = orderres.orders
                            
                            
                            print("Order: \(self.orderDetail)")
                            completion(true)
                        } catch {
                            print("Error decoding Order data: \(error)")
                            completion(false)
                        }
                    } else {
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("Error fetching Order data: \(error)")
                    self.orderDetail = nil
                    completion(false)
                }
            }
        
    }
    
    
    struct ErrorResponse: Codable {
        let message: String
        // You might need to adapt the structure of this based on your backend response format
    }
    
    
    func CancelOrder (completion: @escaping (Bool) -> Void) {
        
        if let authtoken = TokenManager.shared.getToken() {
            
            // Define the API endpoint URL
            let apiUrl = "http://localhost:8000/deleteorder" // Replace with your actual API URL
            
            // Define the headers with the authentication token
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(authtoken)"
            ]
            
            
            AF.request(apiUrl, method: .post, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let responseData = response.data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                                print("Response JSON: \(json)")
                            } catch {
                                print("Error decoding response data: \(error)")
                            }
                        }
                        
                    case .failure(let error):
                        print("Error deleting order: \(error)")
                        
                        if let responseData = response.data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                                print("Error response JSON: \(json)")
                            } catch {
                                print("Error decoding error response data: \(error)")
                            }
                        }
                    }
                }
        }else {
            completion(false)
        }
        
    }
    
    func GetAllOrders (authtoken : String ,completion: @escaping (Bool) -> Void) {
        // Define the API endpoint URL
        let apiUrl = "http://localhost:8000/allorders" // Replace with your actual API URL
        
        // Define the headers with the authentication token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authtoken)"
        ]
        
        // Make the GET request
        AF.request(apiUrl, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let responseData = response.data {
                        do {
                            let ordersResponse = try JSONDecoder().decode(getAllOedResp.self, from: responseData)
                            
                            self.ClientAllOrders = ordersResponse.orders
                            
                            print("Orders: \(self.ClientAllOrders)")
                            completion(true)
                        } catch {
                            print("Error decoding Order data: \(error)")
                            completion(false)
                        }
                    } else {
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("Error fetching Order data: \(error)")
                    self.orderDetail = nil
                    completion(false)
                }
            }
        
        
    }

    
    
    
    
    func ReciveOrder (authtoken : String , completion: @escaping (Bool) -> Void) {
        
            
            // Define the API endpoint URL
            let apiUrl = "http://localhost:8000/ReciveOrder" // Replace with your actual API URL
            
            // Define the headers with the authentication token
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(authtoken)"
            ]
            
       
            AF.request(apiUrl, method: .post, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let responseData = response.data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                                print("Response JSON: \(json)")
                            } catch {
                                print("Error decoding response data: \(error)")
                            }
                        }
                        
                    case .failure(let error):
                        print("Error deleting order: \(error)")
                        
                        if let responseData = response.data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                                print("Error response JSON: \(json)")
                            } catch {
                                print("Error decoding error response data: \(error)")
                            }
                        }
                    }
                }
        }
    }

