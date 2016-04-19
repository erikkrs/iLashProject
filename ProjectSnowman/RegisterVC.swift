//
//  RegisterVC.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController
{
    @IBOutlet weak var roleSegments: UISegmentedControl!
    @IBOutlet weak var errorTextView: UITextView!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmEmailTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //empty error text by default
        self.errorTextView.text = ""
    }

    func validateForm() -> Bool
    {
        var errorMessage = ""
        if(self.emailTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter an email address"
        }
        else if(!Core.isValidEmail(self.emailTF.text!))
        {
            errorMessage = "You must enter an valid email address"
        }
        else if(self.confirmEmailTF.text?.characters.count == 0)
        {
            errorMessage = "You must confirm the email address"
        }
        else if(self.passwordTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a password"
        }
        else if(self.confirmPasswordTF.text?.characters.count == 0)
        {
            errorMessage = "You must confirm the password"
        }
        else if(self.passwordTF.text! != self.confirmPasswordTF.text!)
        {
            errorMessage = "Passwords do not match"
        }
        else if(self.emailTF.text! != self.confirmEmailTF.text!)
        {
            errorMessage = "Email addresses do not match"
        }
        else
        {
            self.errorTextView.text = ""
            return true
        }
        self.errorTextView.text = errorMessage
        self.errorTextView.textColor = UIColor.redColor()
        return false
    }
    
    @IBAction func createButtonPressed(sendar : AnyObject)
    {
        if(self.validateForm())
        {
            let ref = Core.fireBaseRef
            ref.createUser(self.emailTF.text!, password: self.passwordTF.text!,
                           withValueCompletionBlock: { error, result in
                            if error != nil
                            {
                                // There was an error creating the account
                                self.errorTextView.text = error.localizedDescription
                                self.errorTextView.textColor = UIColor.redColor()
                            }
                            else
                            {
                                var role = "user"
                                if(self.roleSegments.selectedSegmentIndex == 1)
                                {
                                    role = "provider"
                                }
                                
                                let roleRef = ref.childByAppendingPath("role")
                                roleRef.childByAppendingPath(result["uid"] as! String).setValue(role)
                                let alert = UIAlertController(title: "Success", message: "Account Successfully Created - You may now login", preferredStyle: .Alert)
                                let okAction = UIAlertAction(title: "OK", style: .Default
                                    , handler: { (action: UIAlertAction) in
                                    self.dismissViewControllerAnimated(false, completion: nil)
                                })
                                alert.addAction(okAction)
                                self.presentViewController(alert, animated: true, completion: nil)
                            }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
