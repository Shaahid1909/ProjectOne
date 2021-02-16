//
//  ViewController.swift
//  projectOne
//
//  Created by Admin Mac on 12/02/21.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var LogBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0        
        LogBtn.layer.cornerRadius = 12.0
        
    
    }

    
    @IBAction func logBtnTapped(_ sender: UIButton) {
    
        // Create cleaned versions of the text field
        let username = UserNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                 let navigationController = storyBoard.instantiateViewController(withIdentifier: "HomeNavigationContoller") as! UINavigationController

                 let vc = storyBoard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
                
                 navigationController.pushViewController(vc, animated: true)
                 navigationController.modalPresentationStyle = .fullScreen
                
                self.present(navigationController, animated: true, completion: nil)
                
           //    let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeView") as? HomeViewController
                
             //  self.navigationController?.pushViewController(homeViewController!, animated: true)
                
            //   self.present(homeViewController!, animated: true)
             //  self.view.window?.rootViewController = homeViewController
          //   self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
        
        
        
        
        
    
    
    
    
   



