//
//  LoginViewController.swift
//  FireBaseApp
//
//  Created by Gokul Murugan on 2022-12-22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{
    
    
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Login"
        emailUser?.delegate = self
        passWord?.delegate = self
        emailUser?.returnKeyType = .continue
        passWord?.returnKeyType = .continue
        passWord?.isSecureTextEntry = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegiser))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ConversationsViewController") as! ConversationsViewController
            self.navigationController?.pushViewController(resultViewController, animated: false)
        }
    }
    
    
    @objc private func didTapRegiser(){
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        emailUser.resignFirstResponder()
        passWord.resignFirstResponder()
        if emailUser.text == nil || passWord.text == nil || passWord.text!.count < 6 {
            
            alert(with: "Invalid Details",
                  message: "Please Check user name and Password and try again")
        }
        else {
            
            FirebaseAuth.Auth.auth().signIn(withEmail: emailUser.text!, password: passWord.text!){ [weak self] authResult, authError in
                guard authError == nil else{
                    self?.alert(with: "Login Unsuccessful",
                                message: authError!.localizedDescription)
                    return
                }
                guard let vc =  self?.storyBoard.instantiateViewController(withIdentifier: "TabBarController") else {return}
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
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
    
    func alert(with title:String, message:String){
        let alert = UIAlertController(title: title ,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
        
    }
}
