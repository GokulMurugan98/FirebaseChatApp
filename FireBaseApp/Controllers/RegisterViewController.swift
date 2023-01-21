//
//  RegisterViewController.swift
//  FireBaseApp
//
//  Created by Gokul Murugan on 2022-12-22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailUser?.delegate = self
        passWord?.delegate = self
        firstName?.delegate = self
        lastName?.delegate = self
        firstName?.returnKeyType = .continue
        lastName?.returnKeyType = .continue
        emailUser?.returnKeyType = .continue
        passWord?.returnKeyType = .continue
        passWord?.isSecureTextEntry = true
        image?.layer.masksToBounds = true
        image?.layer.cornerRadius = image.frame.width/2.0
        image?.layer.borderColor = UIColor.lightGray.cgColor
        image?.layer.borderWidth = 2
    }
    
    @IBAction func profilePictureTap(_ sender: Any) {
        imagePick()
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
            FirebaseAuth.Auth.auth().createUser(withEmail: emailUser.text!, password: passWord.text!) { [weak self] AuthDataResult, authError in
                
                guard authError == nil else  {
                    
                    let alert = UIAlertController(title: "Registration Unsuccesful" ,
                                                  message: authError?.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: { _ in
                        self?.navigationController?.popViewController(animated: true)
                    }))
                    self?.present(alert, animated: true)
                    return
                }
                DatabaseManager.shared.createUser(with: User(email: self!.emailUser.text!, firstName: self!.firstName.text!, lastName: self!.lastName.text!))
                
                self?.navigationController?.popViewController(animated: true)
            }
            
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


extension RegisterViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePick(){
        
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to choose an image?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {[weak self] _ in
            self?.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: {[weak self] _ in
            self?.photoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func camera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    func photoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true )
        guard let selectedImage = info[.editedImage] as? UIImage else { return  }
        
        
        self.image.image = selectedImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true )
    }
    
    
    
}
