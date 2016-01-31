//
//  JurorCallback.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/30/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class JurorCallback: NSObject {
    
    let myAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myCases: YourJuriesViewController!
    
    init(owner: YourJuriesViewController) {
        super.init()
        myCases = owner
    }
    
    func fillJurorCases() {
        myCases.setDataForTable(myAppDelegate.appModel.caseArray)
    }
}