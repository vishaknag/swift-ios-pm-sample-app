//
//  PostViewController.swift
//  Instagram
//
//  Created by Vikram Nag on 6/8/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextField!
    
    @IBAction func chooseImg(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            postImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func postImg(_ sender: Any) {
        
        if let image = postImage.image{
            let post = PFObject(className: "Post")
            post["caption"] = caption.text
            post["userId"] = PFUser.current()?.objectId
            post["username"] = PFUser.current()?.username
            post["likes"] = 0
            
            if let imageData = UIImagePNGRepresentation(image){
                let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                
                spinner.center = self.view.center
                spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                spinner.hidesWhenStopped = true
                view.addSubview(spinner)
                
                spinner.startAnimating()
                
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                let imageFile = PFFile(name: "image.jpg", data: imageData)
                post["imageFile"] = imageFile
                post.saveInBackground(block: { (success, error) in
                    spinner.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil{
                        self.displayAlert(title: "Failed!", message: (error?.localizedDescription)!)
                    }
                    else{
                        self.displayAlert(title: "Success!", message: "Image posted successfully")
                        self.caption.text = ""
                        self.postImage.image = nil
                    }
                })
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField:UITextField ) -> Bool{
        textField.resignFirstResponder()
        return true

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
