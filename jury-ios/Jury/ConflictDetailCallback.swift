//
//  ConflictDetailCallback.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/31/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class ConflictDetailCallback: NSObject {
    
    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myCase: ConflictDetailViewController!
    
    init(owner: ConflictDetailViewController) {
        super.init()
        myCase = owner
    }
    
    func fillConflictDetails(details: NSArray) {
        myCase.updateDetails(details)
    }
}