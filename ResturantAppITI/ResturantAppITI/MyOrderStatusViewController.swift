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
    var activityIndicatorView2: NVActivityIndicatorView!
    var activityIndicatorView3: NVActivityIndicatorView!



    


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
                frame: CGRect(x: 0, y: -52, width: 65, height: 65),
                type: .ballPulse,
                color: .systemBlue,
                padding: nil
            )
            
            activityIndicatorView2 = NVActivityIndicatorView(
                frame: CGRect(x: 0, y: -52, width: 65, height: 65),
                type: .ballPulse,
                color: .systemPink,
                padding: nil
            )
            
            activityIndicatorView3 = NVActivityIndicatorView(
                frame: CGRect(x: 0, y: -52, width: 65, height: 65),
                type: .ballPulse,
                color: .systemYellow,
                padding: nil
            )
            
            
            
            activityIndicatorView.center = self.view.center
            activityIndicatorView2.center = self.view.center
            activityIndicatorView3.center = self.view.center


            self.view.addSubview(activityIndicatorView)
            self.view.addSubview(activityIndicatorView2)
            self.view.addSubview(activityIndicatorView3)


            
        }

    @IBAction func cancelAnOrder(_ sender: Any) {
        
        OrderController.shared.CancelOrder(){
            suc in
            if suc {
                print("cancelled")
            } else {
                print("error cancelling Order")
            }
        }
    }
    
    @IBAction func ReciveanOrder(_ sender: Any) {
        if let auth = TokenManager.shared.getToken() {
            OrderController.shared.ReciveOrder(authtoken: auth){
                success in
                DispatchQueue.main.async {
                    if success {
                        let successAlert = UIAlertController(title: "Order Received", message: "Happy Meal", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        successAlert.addAction(okAction)
                        self.present(successAlert, animated: true, completion: nil)
                    } else {
                        let errorAlert = UIAlertController(title: "Error Receiving Order", message: "Try again", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        errorAlert.addAction(okAction)
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var ReciveOrderButton: UIButton!
    
    @IBOutlet weak var cancelOrderButton: UIButton!
    @IBOutlet weak var gif: UIImageView!
    func refreshView() {
            if let auth = TokenManager.shared.getToken() {
                OrderController.shared.GetCurrentOrder(authtoken: auth){
                    success in
                    if success {
                        if OrderController.shared.orderDetail.Status == "pending" {
                            self.gif.image = UIImage(systemName: "fork.knife.circle")
                            self.gif.tintColor = .systemBlue
                            self.OrderstatusLabel.text = "Your Order is being pending"
                            self.activityIndicatorView.startAnimating()
                            self.cancelOrderButton.isHidden = false
                            self.ReciveOrderButton.isHidden = true
                            
                            self.activityIndicatorView2.stopAnimating()
                            self.activityIndicatorView3.stopAnimating()

                            
                            
                        } else if OrderController.shared.orderDetail.Status == "cooking" {
                            
                            
                            self.gif.image = UIImage(systemName: "fork.knife.circle.fill")
                            self.gif.tintColor = .systemPink
                            self.OrderstatusLabel.text = "Your Order is being cooked"
                            self.activityIndicatorView2.startAnimating()
                            self.cancelOrderButton.isHidden = true
                            self.ReciveOrderButton.isHidden = true
                            
                            self.activityIndicatorView.stopAnimating()
                            self.activityIndicatorView3.stopAnimating()


                            
                        } else if  OrderController.shared.orderDetail.Status == "delivry" {
                            
                            
                            
                            self.gif.image = UIImage(systemName: "box.truck.fill")
                            self.gif.tintColor = .systemYellow
                            self.OrderstatusLabel.text = "Your Order is out for delivry"
                            self.activityIndicatorView3.startAnimating()
                            self.ReciveOrderButton.isHidden = false
                            
                            self.activityIndicatorView.stopAnimating()
                            self.activityIndicatorView2.stopAnimating()
                            
                            self.cancelOrderButton.isHidden = true


                        } else {
                            self.OrderstatusLabel.text = "Error getting order details"
                            self.cancelOrderButton.isHidden = true
                            self.activityIndicatorView.stopAnimating()
                            self.activityIndicatorView2.stopAnimating()
                            self.activityIndicatorView3.stopAnimating()
                            self.gif.image = UIImage(systemName: "xmark.app")


                        }
                    

                        
                    } else {
                        self.OrderstatusLabel.text = "No Current Order"
                        
                        
                        self.gif.image = UIImage(systemName: "bag.fill")
                        
                        self.gif.tintColor = .opaqueSeparator

                        
                        self.cancelOrderButton.isHidden = true
                        self.ReciveOrderButton.isHidden = true
                        self.activityIndicatorView.stopAnimating()
                        self.activityIndicatorView2.stopAnimating()
                        self.activityIndicatorView3.stopAnimating()



                        
                        

                        
                        
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
