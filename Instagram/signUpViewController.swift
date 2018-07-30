//
//  signUpViewController.swift
//  Instagram
//
//  Created by Vikram Nag on 6/23/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.
//

import UIKit
import Parse
class signUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetButtonAction(_ sender: Any) {
        
        if emailField.text!.isEmpty {
            
            // show alert message
            let alert = UIAlertController(title: "Email field", message: "is empty", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // request for reseting password
        PFUser.requestPasswordResetForEmail(inBackground: emailField.text!) { (success, error) -> Void in
            if success {
                
                // show alert message
                let alert = UIAlertController(title: "Success", message: "Email for reseting password has been sent.", preferredStyle: UIAlertControllerStyle.alert)
                
                // if pressed OK call self.dismiss.. function
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                print("reset email sent successfully")
            } else {
                if let err = error?.localizedDescription{
                    print(err)
                }
            }
        }
        
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
