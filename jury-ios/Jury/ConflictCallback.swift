//
//  ConflictCallback.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/31/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class ConflictCallback: NSObject {
    
    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myCases: YourConflictsViewController!
    
    init(owner: YourConflictsViewController) {
        super.init()
        myCases = owner
    }
    
    func fillConflictCases() {
        myCases.setDataForTable(myAppDelegate.appModel.caseArray)
    }
}