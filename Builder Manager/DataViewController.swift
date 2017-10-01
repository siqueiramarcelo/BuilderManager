//
//  DataViewController.swift
//  Builder Manager
//
//  Created by Marcelo Siqueira on 29/09/17.
//  Copyright © 2017 Marcelo Siqueira. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var builderTableView: UITableView!
    @IBOutlet weak var dataLabel: UILabel! // title label
    
    var dataObject: String = ""
    var datePicker : UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        builderTableView.delegate = self
        builderTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }
    
    // MARK: - Table view
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "builder", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    // picker
    func doDatePicker(){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 40, y: 0, width: self.view.frame.size.width - 80, height: 200))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePickerMode.countDownTimer
        datePicker.center = view.center
        view.addSubview(self.datePicker)        
        
    }
    
}



























































// limits
