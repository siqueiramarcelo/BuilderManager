//
//  BuilderTableViewCell.swift
//  Builder Manager
//
//  Created by Marcelo Siqueira on 30/09/17.
//  Copyright © 2017 Marcelo Siqueira. All rights reserved.
//

import UIKit

class BuilderTableViewCell: UITableViewCell {


    @IBOutlet weak var daysField: UITextField!
    @IBOutlet weak var hoursField: UITextField!
    @IBOutlet weak var minutesField: UITextField!
    @IBOutlet weak var secondsField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
	var date = NSDate()
    var timer: Timer?
    var deadline = 0
	let dateFormatterGet = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //self.backgroundColor = UIColor(red: 25/255, green: 41/255, blue: 23/255, alpha: 1)
        startButton.addTarget(self, action: #selector(startCountDown), for: .touchUpInside)
        print("startButton: ", startButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func startCountDown(sender:UIButton) {
        
        var secondsToFinish:Double
        var totalSeconds = 0
        var secondsUntilNow = 0.0
        let buildingDays = Int(daysField.text!)! * 24 * 60 * 60
        let buildingHours = Int(hoursField.text!)! * 60 * 60
        let buildingMinutes = Int(minutesField.text!)! * 60
        let buildingSeconds = Int(secondsField.text!)!
        
        totalSeconds = buildingDays + buildingHours + buildingMinutes + buildingSeconds
        secondsUntilNow = NSDate().timeIntervalSince1970
        secondsToFinish = secondsUntilNow + Double(totalSeconds)
        date = NSDate(timeIntervalSince1970: secondsToFinish)
        deadline = totalSeconds
        
        self.endEditing(true)
                
        startUpdating()
        
    }
    
    func startUpdating() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target:self,
                                     selector:#selector(updateTimer),
                                     userInfo:nil,
                                     repeats:true)
    }
    
    @objc func updateTimer() {
       
        let currentDate = NSDate()
        let currentTime = currentDate.timeIntervalSince1970
        let totalSeconds = date.timeIntervalSince1970
        let timeToGo = totalSeconds - currentTime
        
        let doubleDays = timeToGo / 24 / 60 / 60
        let doubleRoundDays = floor(doubleDays)
        let intDays = Int(doubleRoundDays)
        let daysOnlyInSeconds = intDays * 24 * 60 * 60
        
        let hoursTotalInSeconds = timeToGo - Double(daysOnlyInSeconds)
        let doubleHours = hoursTotalInSeconds / 60 / 60
        let doubleRoundHours = floor(doubleHours)
        let intHours = Int(doubleRoundHours)
        let hoursOnlyInSeconds = intHours * 60 * 60
        
        let minutesTotalInSeconds = hoursTotalInSeconds - Double(hoursOnlyInSeconds)
        let doubleMinutes = minutesTotalInSeconds / 60
        let doubleRoundMinutes = floor(doubleMinutes)
        let intMinutes = Int(doubleRoundMinutes)
        let minutesOnlyInSeconds = intMinutes * 60
        
        let doubleSeconds = minutesTotalInSeconds - Double(minutesOnlyInSeconds)
        let intSeconds = Int(doubleSeconds)
        
        daysField.text = String(intDays)
        hoursField.text = String(intHours)
        minutesField.text = String(intMinutes)
        secondsField.text = String(intSeconds)
        
        deadline -= 1
        
        if deadline == 1 {
            stopUpdating()            
        }
        
        //print(intSeconds)
    }
    
    
    func stopUpdating() {
        timer!.invalidate()

    }
    
}




























































// limits
