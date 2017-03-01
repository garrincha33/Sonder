//
//  SignInViewController.swift
//  Sonder
//
//  Created by Richard Price on 31/12/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

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

    }


}
