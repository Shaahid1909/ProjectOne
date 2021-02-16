//
//  SignupView.swift
//  projectOne
//
//  Created by Admin Mac on 12/02/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupView: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var UserNameF: UITextField!
    @IBOutlet weak var PasswordF: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        errorLabel.alpha = 0
        
        signupBtn.layer.cornerRadius = 12.0

        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        // Check that all fields are filled in
        if NameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            UserNameF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        return nil
    }
    
        @IBAction func SignUpTapped(_ sender: Any) {
            
        let error = validateFields()
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let namefield = NameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = UserNameF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: username, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["Name":namefield, "Username":username,"Password":password, "uid": result!.user.uid ]) { (error) in
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }}
                    self.transitionToHome()
                }}}

    }
    
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
   
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeView") as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    


}
