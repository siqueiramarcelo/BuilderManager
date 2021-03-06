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
    
	var accountIndex = 0
    var builderIndex = 0
    var builderTimer: Timer?
    var deadline = 0
    var deadlineKey = ""
	let dateFormatterGet = DateFormatter()
    
    func manageCountdown() {

        deadline = defaults.integer(forKey: deadlineKey)
        
        if deadline == 0 {
            startButton.addTarget(self, action: #selector(startCountdown), for: .touchUpInside)
            print("manageCountdown set button to startCountdown")
        } else {
            print("manageCountdown call startUpdating")
            startUpdating()
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func startCountdown() {
print("called startCountDown")
        
        daysField.isEnabled = false
        hoursField.isEnabled = false
        minutesField.isEnabled = false
        
        var secondsUntilNow = 0
        var totalSeconds = 0
        
        fillEmptyFields()

        let buildingDays = Int(daysField.text!)! * 24 * 60 * 60
        let buildingHours = Int(hoursField.text!)! * 60 * 60
        let buildingMinutes = Int(minutesField.text!)! * 60
        let buildingSeconds = Int(secondsField.text!)!
        
        totalSeconds = buildingDays + buildingHours + buildingMinutes + buildingSeconds
        secondsUntilNow = Int(NSDate().timeIntervalSince1970)
        
        deadline = secondsUntilNow + totalSeconds
        defaults.set(deadline, forKey: deadlineKey)
        defaults.synchronize()
        
        self.endEditing(true)
        startUpdating()
        
    }
    
    @objc func stopCountDown() {
        
        builderTimer!.invalidate()
print("timer", builderTimer!, " invalidate on cell", deadlineKey)
        deadline = 0
        defaults.set(0, forKey: deadlineKey)
        defaults.synchronize()
        
        resetFields()
        
        daysField.isEnabled = true
        hoursField.isEnabled = true
        minutesField.isEnabled = true
        
        switchButton(state: "Start")
        
    }

    func startUpdating() {
        print("startUpdating will call switchButton")
        switchButton(state: "Reset")

        builderTimer = Timer.scheduledTimer(timeInterval: 1,
                                            target:self,
                                            selector:#selector(updateTimer),
                                            userInfo:nil,
                                            repeats:true)
        print("timer", builderTimer!, " init on cell", deadlineKey)

    }
    
    @objc func updateTimer() {
       
        let currentDate = NSDate()
        let currentTime = Int(currentDate.timeIntervalSince1970)
        let timeToGo = deadline - currentTime
        
        let daysOnly = timeToGo / 24 / 60 / 60 // days
        let daysOnlyInSeconds = daysOnly * 24 * 60 * 60 // days seconds
        
        let hoursTotalInSeconds = timeToGo - daysOnlyInSeconds // hours seconds
        let hoursOnly = hoursTotalInSeconds / 60 / 60 // hours
        let hoursOnlyInSeconds = hoursOnly * 60 * 60
        
        let minutesTotalInSeconds = hoursTotalInSeconds - hoursOnlyInSeconds
        let minutesOnly = minutesTotalInSeconds / 60
        let minutesOnlyInSeconds = minutesOnly * 60
        
        let secondsOnly = minutesTotalInSeconds - minutesOnlyInSeconds
        
        //print("",daysOnly,":",hoursOnly,":",minutesOnly,":",secondsOnly)
        
        daysField.text = String(daysOnly)
        hoursField.text = String(hoursOnly)
        minutesField.text = String(minutesOnly)
        secondsField.text = String(secondsOnly)
       
        if timeToGo < 1 {

            print("stopCountDown")
            print("updateTimer will call switchButton")
            resetFields()
            switchButton(state: "Start")

            stopCountDown()
        }

    }
    
    func switchButton(state: String) {
        print("switchButton to", state)
        startButton.removeTarget(nil, action: nil, for: .allEvents)
        
        if state == "Start" {
            startButton.addTarget(self, action: #selector(startCountdown), for: .touchUpInside)
        } else {
            startButton.addTarget(self, action: #selector(stopCountDown), for: .touchUpInside)
        }
        
        startButton.setTitle(state, for: .normal)
        
    }
    
    func fillEmptyFields() {
        if daysField.text?.count == 0 {daysField.text = String(0)}
        if hoursField.text?.count == 0 {hoursField.text = String(0)}
        if minutesField.text?.count == 0 {minutesField.text = String(0)}
        if secondsField.text?.count == 0 {secondsField.text = String(0)}
    }
    
    func resetFields() {
        daysField.text = String(0)
        hoursField.text = String(0)
        minutesField.text = String(0)
        secondsField.text = String(0)
    }
    
}




























































// limits
