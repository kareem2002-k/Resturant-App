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

    @IBOutlet weak var OrderstatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if UserAuth.shared.CurrentUser.currentOrderID != 0 {
            self.OrderstatusLabel.text = "Pending"
            
            let activityIndicatorView = NVActivityIndicatorView(
                frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                type: .ballBeat,
                color: .blue,
                padding: nil
            )
            activityIndicatorView.center = self.view.center
            self.view.addSubview(activityIndicatorView)
            
            activityIndicatorView.startAnimating()
        } else {
            self.OrderstatusLabel.text = "No current Order"
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
