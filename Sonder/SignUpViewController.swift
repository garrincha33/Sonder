//
//  SignUpViewController.swift
//  Sonder
//
//  Created by Richard Price on 01/01/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    var selectedImage: UIImage?
    
    var allUids = [String]()
    var allUsersArray = [String]()
    
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

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        signUpButton.isEnabled = false
        handleTextField()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    //----validation methods-----------
    
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signUpButton.isEnabled = false
            return
        }
        signUpButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
        signUpButton.isEnabled = true
    }

    //----validation methods----------
    
    func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
  
    }


    func checkUsername(username: String) {
        
        allUsers =  DataService.data.REF_USERS
        allUsers.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict1 = snapshot.value as? [String: AnyObject] {
                // interage throw user list
                for (key, value) in dict1 {
                    // check if if user exists and extract username only
                    if let user = value as? NSDictionary, let userName = user["username"] as? String {
                        // store all usernames and user ids
                        self.allUsersArray.append(userName)
                        self.allUids.append(key)
                    }
                }
                
                print("array is \(self.allUsersArray)")
                if self.checkIfUsernameExists(username: username) { // check if user names already exists
                    // if users exists mark username field with red color, otherwise with green
                    self.addBorderForField(field: self.usernameTextField, with: .red)
                    print("this username already exists")
                } else {
                    self.addBorderForField(field: self.usernameTextField, with: .green)
                }
            }
        })
    }
    
    func addBorderForField(field: UITextField, with color: UIColor) {
        field.layer.borderColor = color.cgColor
        field.layer.borderWidth = 1
    }
 
    func checkIfUsernameExists(username: String) -> Bool {

        return !allUsersArray.filter({ $0.lowercased() == username.lowercased() }).isEmpty
    }
    
   
   
    
    @IBAction func backToSignInBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func singUpBtnPressed(_ sender: Any) {
        
        if checkIfUsernameExists(username: usernameTextField.text!) {
            ProgressHUD.showError("Username already exists")
            return
        }
       
        view.endEditing(true)
        ProgressHUD.show("Waiting", interaction: false)
            if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            AuthService.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                ProgressHUD.showSuccess("SignUp SuccessFul")
                self.performSegue(withIdentifier: "signUpTabVC", sender: nil)
            }, onError: {(errorString) in
                ProgressHUD.showError(errorString!)
            })
            
        } else {

            ProgressHUD.showError("profile image can't be empty")
            
        }
        
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            checkUsername(username: textField.text!)
        }
    }
    //----prevent white space from being entered when choosing a username
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSetNotAllowed = CharacterSet(charactersIn: " ")
        if let _ = string.rangeOfCharacter(from: characterSetNotAllowed, options: .caseInsensitive) {
            return false
        } else {
            return true
        }
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            profileImage.image = image
            profileImage.clipsToBounds = true
            
        }
        dismiss(animated: true, completion: nil)
    }
}
    
    

