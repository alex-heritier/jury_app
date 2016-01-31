//
//  CaseDetailViewController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/30/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//
//Used code from:
//http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

import UIKit

class CaseDetailViewController: UIViewController {
    
    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var prosecutorIn: String!
    var defendantIn: String!
    var descriptionIn: String!
    var caseID: Int!
    var voteID: Int!
    
    @IBOutlet weak var prosecutorField: UITextField!
    @IBOutlet weak var defendantField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var commentaryView: UITextView!
    @IBOutlet weak var verdictSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prosecutorField.text = prosecutorIn
        defendantField.text = defendantIn
        descriptionView.text = descriptionIn
        
        let borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        commentaryView.layer.borderColor = borderColor.CGColor
        commentaryView.layer.borderWidth = 1.0
        commentaryView.layer.cornerRadius = 5.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func judgeButton(sender: UIButton) {
        var verdict: Int = 0
        if verdictSwitch.on {
            verdict = 0
        }
        else {
            verdict = 1
        }
        print("Submitting verdict...");
        myAppDelegate.networkingController.submitVerdict(caseID, voteID: voteID, verdict: verdict, commentary: commentaryView.text)
        
        dispatch_async(dispatch_get_main_queue(),{
            print("lel")
            self.performSegueWithIdentifier("submitVerdictSegue", sender: sender)
        })
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
