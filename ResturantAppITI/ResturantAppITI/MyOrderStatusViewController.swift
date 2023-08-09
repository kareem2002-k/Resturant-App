//
//  MyOrderStatusViewController.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 09/08/2023.
//

import UIKit

import NVActivityIndicatorView

import Alamofire

class MyOrderStatusViewController: UIViewController {
    
    var CurrentUser : User!
    var activityIndicatorView: NVActivityIndicatorView!


    @IBOutlet weak var OrderstatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

              setupActivityIndicator()

              refreshView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            refreshView()
        }

        func setupActivityIndicator() {
            activityIndicatorView = NVActivityIndicatorView(
                frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                type: .ballBeat,
                color: .blue,
                padding: nil
            )
            activityIndicatorView.center = self.view.center
            self.view.addSubview(activityIndicatorView)
        }

        func refreshView() {
            if let auth = TokenManager.shared.getToken() {
                OrderController.shared.GetCurrentOrder(authtoken: auth){
                    success in
                    if success {
                        self.OrderstatusLabel.text = OrderController.shared.orderDetail.Status
                        
                        self.activityIndicatorView.startAnimating()

                        
                    } else {
                        self.OrderstatusLabel.text = "No Current Order"
                        
                        self.activityIndicatorView.stopAnimating()
                    }
                }
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
