//
//  RemindersTableViewController.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/30/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class RemindersTableViewController: UITableViewController {
    @IBOutlet weak var remindersSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
