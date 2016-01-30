//
//  NetworkingController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/29/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

//used code from this url:
//http://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method

import UIKit

class NetworkingController: NSObject, NSURLConnectionDelegate {
    
    var myAppDelegate: AppDelegate!
    var data = NSMutableData()
    
    
    init(appdelegate: AppDelegate) {
        super.init()
        myAppDelegate = appdelegate
    }
    
    func sendConflict(prosecutorText: String, defenderText: String, descriptionText: String) {
        var originalUrl = "http://www.aheritier.com/jury/server/create_case.php?prosecutor=\(prosecutorText)"
        originalUrl += "&defender=\(defenderText)&description=\(descriptionText)"
        originalUrl += "&user_id=\(myAppDelegate.appModel.userID)"
        let urlString = originalUrl.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        let request = NSMutableURLRequest(URL: NSURL(string:
            urlString)!)
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
    }
    
    func sendLoginCredentials(usernameText: String, passwordText: String) {
        let originalUrl = "http://www.aheritier.com/jury/server/login.php?username=" + usernameText + "&password=" + passwordText
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
                    self.myAppDelegate.appModel.username = usernameText
                    self.myAppDelegate.appModel.canLogin = true
                }
                else {
                    print("Wrong Password")
                }
            }
        }
        task.resume()
    }
    
}
