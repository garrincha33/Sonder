//
//  CameraVC.swift
//  Sonder
//
//  Created by Richard Price on 27/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
class CameraVC: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var clear: UIBarButtonItem!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tap)
        photo.isUserInteractionEnabled = true
        
   
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    func handlePost() {
        if selectedImage != nil {
            self.shareButton.isEnabled = true
            self.clear.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            
        } else {
            self.shareButton.isEnabled = false
            self.clear.isEnabled = false
            self.shareButton.backgroundColor = .lightGray
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated:  true, completion: nil)
        
    }

    func clean() {
        self.captionTextView.text = ""
        self.photo.image = UIImage(named: "Placeholder-image")
        self.selectedImage = nil
    }
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting")
        if let photo = self.selectedImage, let imageData = UIImageJPEGRepresentation(photo, 0.1) {
            HelperService.uploadDataToServer(data: imageData, caption: captionTextView.text!, onSucess: {
            self.clean()
            self.tabBarController?.selectedIndex = 0
            
            })
            
        } else {
            
            ProgressHUD.showError("photo cant be empty")
        }
    }
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        clean()
        handlePost()
    }
    
}

extension CameraVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("finished picking media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}


