//
//  LoginViewController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/29/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: UIButton) {
        myAppDelegate.networkingController.sendLoginCredentials(usernameField.text!, passwordText: passwordField.text!)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            while !self.myAppDelegate.appModel.canLogin {
                NSThread.sleepForTimeInterval(1/100)
            }
            dispatch_async(dispatch_get_main_queue(),{
                self.performSegueWithIdentifier("loginSuccessSegue", sender: self)
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}
