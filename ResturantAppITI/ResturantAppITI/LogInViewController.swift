//
//  LogInViewController.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 07/08/2023.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class LogInViewController: UIViewController {
    
    let activityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 40, height: 40),
        type: .ballClipRotate,
        color: .blue,
        padding: nil
    )
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if  TokenManager.shared.getToken() != nil  {
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
         
       
         self.activityIndicatorView.center = self.view.center
         self.view.addSubview(activityIndicatorView)

         // Show loading indicator
         self.activityIndicatorView.startAnimating()

            UserAuth.shared.Login(email: emailLabel.text!, password: passwordLabel.text!) { success in
                // Hide loading indicator
                self.activityIndicatorView.stopAnimating()

                if success {
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarControllerID") as? TabBarController {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let delegate = windowScene.delegate as? SceneDelegate {
                                delegate.window?.rootViewController = tabBarController
                            }
                        }
                    }
                } else {
                    let missingInformationAlert = UIAlertController(title: "Auth Error", message: "Invalid Email or Password. Try again.", preferredStyle: .alert)
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
