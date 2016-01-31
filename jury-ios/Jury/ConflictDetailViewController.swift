//
//  ConflictDetailViewController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/31/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class ConflictDetailViewController: UIViewController {

    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var conflictDetailCallback: ConflictDetailCallback!
    
    var prosecutorIn: String!
    var defendantIn: String!
    var descriptionIn: String!
    var caseID: Int!
    
    @IBOutlet weak var prosecutorField: UITextField!
    @IBOutlet weak var defendantField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var verdictField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conflictDetailCallback = ConflictDetailCallback(owner: self)
        
        prosecutorField.text = prosecutorIn
        defendantField.text = defendantIn
        descriptionView.text = descriptionIn
        
        myAppDelegate.networkingController.askForVerdictsForCase(caseID, callback: conflictDetailCallback)

        // Do any additional setup after loading the view.
    }
    
    func updateDetails(details: NSArray) {
        var prosecutorVotes = 0
        var defendantVotes = 0
        var undecidedVotes = 0
        
        for detail in details{
            if Int(detail["verdict"] as! String) < 0 {
                undecidedVotes++
            }
            if Int(detail["verdict"] as! String) == 0 {
                defendantVotes++
            }
            if Int(detail["verdict"] as! String) > 0 {
                prosecutorVotes++
            }
        }
        
        dispatch_async(dispatch_get_main_queue(),{
            if undecidedVotes > 6 {
                self.verdictField.text = "There is no verdict yet."
            }
            if defendantVotes > 6 {
                self.verdictField.text = "NOT GUILTY."
            }
            if prosecutorVotes > 6 {
                self.verdictField.text = "GUILTY."
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
