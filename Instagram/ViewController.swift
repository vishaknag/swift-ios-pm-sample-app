//
//  ViewController.swift
//  Instagram
//
//  Created by Vikram Nag on 6/7/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signUpModeActive = true

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func Signup(_ sender: Any) {
        
        if email.text! == "" || password.text! == "" || isValidEmail(testStr:email.text!) == false{
            displayAlert(title: "Login error", message: "Please check your email and Password")
        }
        else{
            let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            spinner.center = self.view.center
            spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            spinner.hidesWhenStopped = true
            view.addSubview(spinner)
            
            spinner.startAnimating()
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signUpModeActive{
                print("Signing up...")
                
                let user = PFUser()
                user.username = email.text
                user.password = password.text
                user.email = email.text
                
//                let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
//                let avaFile = PFFile(name: "ava.jpg", data: avaData!)
//                user["ava"] = avaFile
                
                user.signUpInBackground(block: { (success, error) in
                    spinner.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if let err = error{
                        self.displayAlert(title: "Could not complete sign up", message: err.localizedDescription)
                    }
                    else{
                        print("Signed up successfully")
                        self.performSegue(withIdentifier: "userTableView", sender: self)
                    }
                })
            }
            else{
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: { (user, error) in
                    spinner.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if user != nil{
                        print("login successful")
                        self.performSegue(withIdentifier: "userTableView", sender: self)
                    }
                    else{
                        var err = "Unknown error.Please try again."
                        if let error = error{
                            err = error.localizedDescription
                        }
                        self.displayAlert(title: "Login failed", message: err)
                    }
                })
            }
            
            
            
        }
        
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func login(_ sender: Any) {
        
        if(signUpModeActive){
            signUpModeActive = false
            SignUpButton.setTitle("Login", for: [])
            loginButton.setTitle("Sign up", for: [])
        }
        else{
            signUpModeActive = true
            SignUpButton.setTitle("Sign up", for: [])
            loginButton.setTitle("Login", for: [])
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil{
            performSegue(withIdentifier: "userTableView", sender: self)
        }
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

