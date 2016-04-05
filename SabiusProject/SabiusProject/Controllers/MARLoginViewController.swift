//
//  MARLoginViewController.swift
//  ParseStarterProject-Swift
//
//  Created by miguelicious on 2/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MARLoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    
    
    @IBOutlet weak var marLogin: UIButton!
    @IBOutlet weak var marSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = "aramis001@gmail.com"
        password.text = "Password123"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginWasPressed(sender: AnyObject) {
        if email.text != "" && password.text != "" {
            PFUser.logInWithUsernameInBackground(email.text!, password: password.text!, block: { (user: PFUser?, error: NSError?) -> Void in
                if error == nil {
                    print("user logged in successfully")
                    
                } else {
                    print(error)
                }
            })
        }
    }
    
    @IBAction func signupWasPressed(sender: AnyObject) {
        if email.text != "" && password.text != "" && confirm.text == password.text{
            let user = PFUser()
            user.username = email.text
            user.email = email.text
            user.password = password.text
            
            user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if success {
                    
                    print("User signed up successfully")
                } else {
                    print(error)
                }
            })
        }
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }

}

extension MARLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        } else {
            loginWasPressed(self)
        }
        return true
    }
}
