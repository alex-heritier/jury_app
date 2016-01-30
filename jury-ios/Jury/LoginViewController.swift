//
//  LoginViewController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/29/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: UIButton) {
        
        //TODO: submit name to server
        
        performSegueWithIdentifier("loginSuccessSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}
