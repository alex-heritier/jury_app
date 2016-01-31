//
//  YourJuriesViewController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/30/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class YourJuriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var jurorCallback: JurorCallback!
    @IBOutlet var tableView: UITableView!
    var caseArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 90.0
        
        jurorCallback = JurorCallback(owner: self)
        
        myAppDelegate.networkingController.askForJurorCases(jurorCallback)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caseArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CaseTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("caseCell")! as! CaseTableViewCell
        
        cell.titleField.text = ((caseArray[indexPath.row] as! NSDictionary)["prosecutor"] as! String) + " v. " +
            ((caseArray[indexPath.row] as! NSDictionary)["defender"] as! String)
        cell.descriptionField.text = (caseArray[indexPath.row] as! NSDictionary)["description"] as! String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("caseDetailSegue", sender: self)
    }
    
    func setDataForTable(data: NSArray) {
        caseArray = data
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "caseDetailSegue" {
            let indexRow = self.tableView.indexPathForSelectedRow!.row
            let detailView = segue.destinationViewController as! CaseDetailViewController
            detailView.prosecutorIn = (caseArray[indexRow] as! NSDictionary)["prosecutor"] as? String
            detailView.defendantIn = (caseArray[indexRow] as! NSDictionary)["defender"] as? String
            detailView.descriptionIn = (caseArray[indexRow] as! NSDictionary)["description"] as? String
            detailView.voteID = Int(((caseArray[indexRow] as! NSDictionary)["vote_id"] as? String)!)
            detailView.caseID = Int(((caseArray[indexRow] as! NSDictionary)["id"] as? String)!)
        }
    }
}
