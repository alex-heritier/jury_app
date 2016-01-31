//
//  NetworkingController.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/29/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

//used code from these urls:
//http://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
//https://www.hackingwithswift.com/example-code/system/how-to-parse-json-using-nsjsonserialization

import UIKit

class NetworkingController: NSObject, NSURLConnectionDelegate {
    
    var myAppDelegate: AppDelegate!
    var data = NSMutableData()
    let customAllowedSet =  NSCharacterSet(charactersInString:" =\"#%/<>?@\\^`{|}&*").invertedSet
    
    init(appdelegate: AppDelegate) {
        super.init()
        myAppDelegate = appdelegate
    }
    
    func sendLoginCredentials(usernameText: String, passwordText: String) {
        let urlArg1 = usernameText.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg2 = passwordText.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlString = "http://www.aheritier.com/jury/server/login.php?username=" + urlArg1 + "&password=" + urlArg2
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
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
                if responseInt > 0 { // Save userID, username, and password to AppDelegate
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
    
    func sendConflict(prosecutorText: String, defenderText: String, descriptionText: String) {
        let urlArg1 = prosecutorText.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg2 = defenderText.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg3 = descriptionText.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg4 = String(myAppDelegate.appModel.userID).stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        
        let urlString = "http://www.aheritier.com/jury/server/create_case.php?prosecutor=" + urlArg1 +
            "&defender=" + urlArg2 + "&description=" + urlArg3 + "&user_id=" + urlArg4
        
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
    
    func askForJurorCases(callback: JurorCallback) {
        let urlArgs = String(myAppDelegate.appModel.userID).stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let urlString = "http://www.aheritier.com/jury/server/get_juror_cases.php?user_id=" + urlArgs
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
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
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                self.myAppDelegate.appModel.caseArray = json
                print(self.myAppDelegate.appModel.caseArray)
                callback.fillJurorCases()
            }
            catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func submitVerdict(caseID: Int, voteID: Int, verdict: Int, commentary: String) {
        let urlArg1 = String(caseID).stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg2 = String(voteID).stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg3 = String(verdict).stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        let urlArg4 = commentary.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        
        let urlString = "http://www.aheritier.com/jury/server/cast_verdict.php?case_id=" + urlArg1 +
            "&vote_id=" + urlArg2 + "&verdict=" + urlArg3 + "&comment=" + urlArg4
        
        print(urlString)
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
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
    
    //caseID, voteID, verdict (1 or 0), and commentary
    
}
