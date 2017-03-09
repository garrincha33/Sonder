//
//  CameraVC.swift
//  Sonder
//
//  Created by Richard Price on 27/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class CameraVC: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    
    var selectedImage: UIImage?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tap)
        photo.isUserInteractionEnabled = true

    }
    
    func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated:  true, completion: nil)
        
    }
    
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        ProgressHUD.show("Waiting")
        if let photo = self.selectedImage, let imageData = UIImageJPEGRepresentation(photo, 0.1) {
            let photoIdString = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoIdString)
            storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                
                let photoURL = metadata?.downloadURL()?.absoluteString
                self.sendDataToDatabase(photoURL: photoURL!)
            })
            
            
        } else {
            
            ProgressHUD.showError("photo cant be empty")
            
        }

    }
    
    func sendDataToDatabase(photoURL: String) {
        let ref = FIRDatabase.database().reference()
        let postsRef = ref.child("posts")
        let newPostId = postsRef.childByAutoId().key
        let newPostReference = postsRef.child(newPostId)
        newPostReference.setValue(["photoURL": photoURL]) { (error, ref) in
            if error != nil {
                
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
          
        }

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














