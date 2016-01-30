//
//  NewConflictViewController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/29/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class NewConflictViewController: UIViewController {
    
    @IBOutlet weak var prosecutorField: UITextField!
    @IBOutlet weak var defenderField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        descriptionTextView.layer.borderColor = borderColor.CGColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 5.0

        // Do any additional setup after loading the view.
    }

    @IBAction func saveConflict(sender: UIBarButtonItem) {
        myAppDelegate.networkingController.sendConflict(prosecutorField.text!,
            defenderText: defenderField.text!, descriptionText: descriptionTextView.text!)
        
        performSegueWithIdentifier("saveConflict", sender: self)
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
