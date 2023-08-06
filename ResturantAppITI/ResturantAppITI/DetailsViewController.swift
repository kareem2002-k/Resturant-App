//
//  DetailsViewController.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 05/08/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    

     let menuItem: MenuItem
        init?(coder: NSCoder, menuItem: MenuItem) {
            self.menuItem = menuItem
            super.init(coder: coder)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
  
   
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var Name: UILabel!
    func updateUI () {
        Name.text = menuItem.name
        price.text = "$ \(menuItem.price)"
    }
    
    @IBOutlet weak var Order: UIButton!
    
    
    
    
    @IBAction func orderButtontap(_ sender: Any) {
        
         UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.Order.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.Order.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        
            MenuController.shared.order.menuItems.append(menuItem)

        
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
