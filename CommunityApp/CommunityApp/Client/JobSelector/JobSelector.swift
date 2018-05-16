//
//  JobSelector.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-16.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit


class JobSelector: UITableViewController {
    var jobs: [Job] = []
    let cellReuseIdentifier: String = "cell"
    var tappedTableRow: Job!
    override func viewDidLoad() {
        super.viewDidLoad()
        jobs = CoreData.tempJob
            //CoreData.getJobs()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TaskManager.segueID {
            let vc = segue.destination as! JobViewer
            // If there is a default job to set then it will set it
            vc.setJob(job: tappedTableRow)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = jobs[indexPath.row].title
        
        // This is where the descripion of the UItableView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedTableRow = jobs[indexPath.row]
        performSegue(withIdentifier: JobViewer.segueID, sender: self)
    }
    
    
    
    
}







