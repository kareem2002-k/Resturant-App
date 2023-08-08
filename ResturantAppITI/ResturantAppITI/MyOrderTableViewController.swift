//
//  MyOrderTableViewController.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 05/08/2023.
//

import UIKit
import Alamofire

class MyOrderTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
            NotificationCenter.default.addObserver(tableView!,
               selector: #selector(UITableView.reloadData),
               name: MenuController.orderUpdatedNotification, object: nil)
      
        let createOrderButton = UIBarButtonItem(
               title: "Create Order",
               image: nil,
               target: self,
               action: #selector(createOrderButtonTapped)
           )
           navigationItem.rightBarButtonItem = createOrderButton

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func createOrderButtonTapped() {
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
        
        // Get the authentication token from your user session or wherever it's stored
        let authToken = TokenManager.shared.getToken() // Replace with the actual token
        
        // Define the headers with the authentication token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken!)"
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
                        // Handle success response here
                    }
                case .failure(let error):
                    print("Error creating order: \(error)")
                    // Handle error response here
                }
            }
        
        
        print(authToken!)
    }


    override func tableView(_ tableView: UITableView,
       canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    override func tableView(_ tableView: UITableView,
       commit editingStyle: UITableViewCell.EditingStyle,
       forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at:
               indexPath.row)
        }
        
        
    }
 
    
  
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuController.shared.order.menuItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt
       indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
           "Order", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }

    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem =
           MenuController.shared.order.menuItems[indexPath.row]
    
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = menuItem.price.formatted(.currency(code:
           "usd"))
        cell.contentConfiguration = content
        
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
