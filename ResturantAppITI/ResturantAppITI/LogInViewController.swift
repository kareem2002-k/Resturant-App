//
//  LogInViewController.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 07/08/2023.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        
        if  TokenManager.shared.getToken() != nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace with your storyboard name
                    if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarControllerID") as? TabBarController {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                             let delegate = windowScene.delegate as? SceneDelegate {
                                              delegate.window?.rootViewController = tabBarController
                      }
                    }
                

            
        } else {
            print("nothing")
        }
        
    }
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
   
     @IBAction func loginTap(_ sender: Any) {
         
         func get(completion: @escaping (Bool) -> Void)  {
             
             let loginURL = "http://localhost:8000/login"
             let parameters: [String: Any] = ["email": emailLabel.text!, "password": passwordLabel.text!]
             AF.request(loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                 .validate(statusCode: 200..<300)
                 .responseJSON { response in
                     switch response.result {
                     case .success:
                         if let token = response.response?.allHeaderFields["Authorization"] as? String {
                             print("done auth ")
                             TokenManager.shared.saveToken(token)
                            completion(true)
                         }
                     case .failure(let error):
                         print("Error: \(error)")
                         completion(false)
                         if let responseData = response.data {
                             do {
                                 if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                                     print("Error JSON: \(json)")
                                 } else {
                                     print("Error response is not in JSON format.")
                                     // You can print responseData as plain text here if needed
                                 }
                             } catch {
                                 print("Error parsing error response: \(error)")
                                 print("Raw Data: \(responseData)")
                             }
                         }
                         
                     }
                 }
             
         }

         get(){ success in
             if success {
                 DispatchQueue.main.async {
                     
                     let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace with your storyboard name
                             if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarControllerID") as? TabBarController {
                                 if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                                      let delegate = windowScene.delegate as? SceneDelegate {
                                                       delegate.window?.rootViewController = tabBarController
                               }
                             }
                         }
                 
             
              } else {
                  let missingInformationAlert = UIAlertController(title: "Auth Eror",message: "Invalid Email or Passsword Try again",
                                                                preferredStyle: .alert)
                                 
                          let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                          
                          
                          missingInformationAlert.addAction(cancelAction)

                          self.present(missingInformationAlert, animated: true, completion: nil)
                 }
             }
         
     }
  
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let secoundView = segue.destination as? SignUpViewController {
            
        }
        
    }

     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
