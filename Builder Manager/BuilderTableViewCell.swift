//
//  BuilderTableViewCell.swift
//  Builder Manager
//
//  Created by Marcelo Siqueira on 30/09/17.
//  Copyright © 2017 Marcelo Siqueira. All rights reserved.
//

import UIKit

class BuilderTableViewCell: UITableViewCell {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(red: 25/255, green: 41/255, blue: 23/255, alpha: 1)
        timePicker.backgroundColor = UIColor(red: 123/255, green: 150/255, blue: 123/255, alpha: 255/255)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
