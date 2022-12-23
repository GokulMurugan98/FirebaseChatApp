//
//  LoginViewController.swift
//  FireBaseApp
//
//  Created by Gokul Murugan on 2022-12-22.
//

import UIKit

class LoginViewController: UIViewController{
    
    
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailUser.delegate = self
        passWord.delegate = self
        emailUser.returnKeyType = .continue
        passWord.returnKeyType = .continue
        passWord.isSecureTextEntry = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegiser))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if loggedIn {
            performSegue(withIdentifier: "conversations", sender: self)
        }
    }
    
    
    @objc private func didTapRegiser(){
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        performSegue(withIdentifier: "registerUser", sender: self)
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        emailUser.resignFirstResponder()
        passWord.resignFirstResponder()
        if emailUser.text == nil || passWord.text == nil || passWord.text!.count < 6 {
            let alert = UIAlertController(title: "Invalid Details",
                                          message: "Please Check user name and Password and try again",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
        }
        else if (emailUser.text == "Gokul" && passWord.text == "123456"){
            emailUser.text = nil
            passWord.text = nil
            performSegue(withIdentifier: "conversations", sender: self)
            
        }
    }
}


extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailUser{
            passWord.becomeFirstResponder()
        }
        else if textField == passWord{
            LoginButton(self)
        }
        return true
    }
}
