//
//  ConflictTableViewCell.swift
//  Jury
//
//  Created by Keegan Papakipos on 1/30/16.
//  Copyright © 2016 kpapakipos. All rights reserved.
//

import UIKit

class ConflictTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
