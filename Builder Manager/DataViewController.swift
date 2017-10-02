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
    
    var accountIndex: Int = 0
    var dataObject: String = ""

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
        print("account: ", accountIndex)
    }
    
    // MARK: - Table view
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BuilderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "builder", for: indexPath) as! BuilderTableViewCell
        
        cell.date = NSDate()
        cell.accountIndex = accountIndex
        cell.builderIndex = indexPath.row
        cell.deadlineKey = "deadline" + String(cell.accountIndex) + "_" + String(cell.builderIndex)
        print(" ")
        //print("deadlineKey ", cell.deadlineKey)
        print(" ")
        return cell
    }
    
}



























































// limits
