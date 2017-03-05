//
//  SignInViewController.swift
//  Sonder
//
//  Created by Richard Price on 31/12/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        emailtextField.backgroundColor = .clear
        emailtextField.tintColor = UIColor.white
        emailtextField.textColor = UIColor.white
        emailtextField.attributedPlaceholder = NSAttributedString(string: emailtextField.placeholder!, attributes:
            [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        emailtextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = .clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes:
            [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        handleTextField()
    }
    
    //----validation methods-----------
    
    func handleTextField() {
      
        emailtextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange() {
        guard let email = emailtextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signInButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signInButton.isEnabled = false
            return
        }
        signInButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
        signInButton.isEnabled = true
    }
    
    //----validation methods-----------
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailtextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                return
                
            }
            
            self.performSegue(withIdentifier: "signIntoTabVC", sender: nil)

        })
        
    }
    
    
    

}
