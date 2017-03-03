//
//  SignUpViewController.swift
//  Sonder
//
//  Created by Richard Price on 01/01/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.backgroundColor = .clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes:
            [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerUser = CALayer()
        bottomLayerUser.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerUser.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLayerUser)
        
        emailTextField.backgroundColor = .clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes:
            [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = .clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes:
            [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        

        profileImage.layer.cornerRadius = 53
        profileImage.clipsToBounds = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true

    }
    
    func handleSelectProfileImageView() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }

    @IBAction func backToSignInBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func singUpBtnPressed(_ sender: Any) {
   
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user: FIRUser?, error: Error?) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                return
            }
            
            let uid = user?.uid
            let url = "gs://sonder-37c77.appspot.com"
            let profilePath = "profile_image"
            let storageRef = FIRStorage.storage().reference(forURL: url).child(profilePath).child(uid!)
            if let profileImg = self.selectedImage, let imageData =  UIImageJPEGRepresentation(profileImg, 0.1) {
                storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        
                        return
                        
                    }

                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
                    let ref = FIRDatabase.database().reference()
                    let usersReference = ref.child("users")
                    print(usersReference.description())
                    let newUserReference = usersReference.child(uid!)
                    newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!, "profileImageUrl": profileImageUrl])
                })
                
            }

        })

    }

}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("did finish picking Media")
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImage = image
            profileImage.image = image
            
        }
       
        dismiss(animated: true, completion: nil)
        
    }
    
}
