//
//  AppModel.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/29/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class AppModel: NSObject {
    
    var userID: Int!
    var username: String!
    var canLogin = false
    var caseArray = NSArray()
    var canDisplayJuries = false
}