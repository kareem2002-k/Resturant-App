//
//  SignUpViewController.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 08/08/2023.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var firstname: UITextField!
    
    
  
    @IBOutlet weak var email: UITextField!
    
  
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var confirmpassword: UITextField!
    
    
    
    
    @IBAction func SignUp(_ sender: Any) {
       
        if password.text != "" && firstname.text != "" && lastname.text != "" && email.text != ""  && password.text == confirmpassword.text {

            UserAuth.shared.Register(email: email.text!, password: password.text!, firstname: firstname.text!, lastname: lastname.text!){ success in
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
                    let missingInformationAlert = UIAlertController(title: "Missing Information",message: "Failed Auth try again",
                                                                  preferredStyle: .alert)
                                   
                            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            
                            missingInformationAlert.addAction(cancelAction)

                            self.present(missingInformationAlert, animated: true, completion: nil)
                }
            }
            
        } else {
            let missingInformationAlert = UIAlertController(title: "Missing Information",
                                                                   message: "All fields is  required",
                                                          preferredStyle: .alert)
                           
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    
                    missingInformationAlert.addAction(cancelAction)

                    self.present(missingInformationAlert, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
