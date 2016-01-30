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
        var urlString1 = "http://www.aheritier.com/jury/server/create_case.php?prosecutor=\(prosecutorField.text!)"
        urlString1 += "&defender=\(defenderField.text!)&description=\(descriptionTextView.text!)"
        urlString1 += "&user_id=\(myAppDelegate.appModel.userID)"
        
        let request = NSMutableURLRequest(URL: NSURL(string:
            urlString1)!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
        }
        task.resume()
        
        performSegueWithIdentifier("submitConflictSegue", sender: self)
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
