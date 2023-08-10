//
//  UserViewController.swift
//  ResturantAppITI
import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var NameLab: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let options = ["My Address","Vouchers", "My Past Orders", "Offers","Settings", "Logout"]

     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.dataSource = self
         tableView.delegate = self
         
         // Register the custom cell class or nib with the table view
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "custcell")
         
         tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
         
         let username = UserAuth.shared.CurrentUser.fullname.capitalized
         
         
         NameLab.text = "\(username) "

     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
     // ... Other methods ...

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "custcell", for: indexPath) as! CustomTableViewCell
         
         cell.optionLabel.text = options[indexPath.row]
         
         // Set icons for each option
         switch indexPath.row {
         case 0:
             cell.optionIcon.image = UIImage(systemName: "location.fill")

             case 1:
                 cell.optionIcon.image = UIImage(systemName: "giftcard")
             case 2:
                 cell.optionIcon.image = UIImage(systemName: "clock")
             case 3:
                 cell.optionIcon.image = UIImage(systemName: "tag")
         case 4:
             cell.optionIcon.image = UIImage(systemName: "gearshape.fill")

             case 5:
                 cell.optionIcon.image = UIImage(systemName: "arrow.right.circle")
             default:
                 break
         }

         
         return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Handle "Vouchers" selection
            break
        case 1:
            // Handle "My Past Orders" selection
            break
        case 2:
            print("Navigating to GetAllMyOrdersTableViewController")
            let allOrders = self.storyboard?.instantiateViewController(withIdentifier: "allmyorder") as! GetAllMyOrdersTableViewController
            
            self.navigationController?.pushViewController(allOrders, animated: false)
            break

        case 3:
            // Handle "Logout" selection
            break
        case 4:
            break
        case 5:
            UserAuth.shared.Logout(){
                suc in
                if suc {
                    print("done")
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "Login") as? LogInViewController {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let delegate = windowScene.delegate as? SceneDelegate {
                                delegate.window?.rootViewController = tabBarController
                            }
                        }
                    }

                    
                }else {
                    let missingInformationAlert = UIAlertController(title: "Error Auth",message: "Failed Logging out",
                                                                  preferredStyle: .alert)
                                   
                            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            
                            missingInformationAlert.addAction(cancelAction)

                            self.present(missingInformationAlert, animated: true, completion: nil)
                }
            }
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Set your desired cell height
    }
}
