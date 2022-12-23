//
//  RegisterViewController.swift
//  FireBaseApp
//
//  Created by Gokul Murugan on 2022-12-22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailUser.delegate = self
        passWord.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        firstName.returnKeyType = .continue
        lastName.returnKeyType = .continue
        emailUser.returnKeyType = .continue
        passWord.returnKeyType = .continue
        passWord.isSecureTextEntry = true
    }
    
    @IBAction func profilePictureTap(_ sender: Any) {
        
        print("Tap detected")
    }
    
    @IBAction func registerButton(_ sender: Any) {
        emailUser.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        passWord.resignFirstResponder()
        
        if firstName.text == nil || lastName.text == nil || emailUser.text == nil || passWord.text == nil || passWord.text!.count < 6 {
            let alert = UIAlertController(title: "Invalid Details",
                                          message: "Please Check user name and Password and try again",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
        }
        else{
            
            
            
        }
    }
}


extension RegisterViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstName{
            lastName.becomeFirstResponder()
        }
        else if textField == lastName{
            emailUser.becomeFirstResponder()
        }
        else if textField == emailUser{
            passWord.becomeFirstResponder()
        }
        else if textField == passWord{
            registerButton(self)
        }
        return true
    }
    
    
}
