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
        
        //used code from this url:
        //http://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
        
        let originalUrl = "http://www.aheritier.com/jury/server/login.php?username=" + usernameField.text! + "&password=" + passwordField.text!
        let urlString = originalUrl.stringByRemovingPercentEncoding
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString!)!)
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
            
            if let responseInt = Int(responseString! as String) {
                if responseInt > 0 {
                    self.myAppDelegate.appModel.userID = responseInt
                    self.myAppDelegate.appModel.username = self.usernameField.text
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.performSegueWithIdentifier("loginSuccessSegue", sender: self)
                    })
                }
                else {
                    print("Wrong Password")
                }
            }
        }
        task.resume()
    }
    
    func lel(){
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}
