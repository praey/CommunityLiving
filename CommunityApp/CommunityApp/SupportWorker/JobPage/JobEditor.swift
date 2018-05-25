//
//  JobEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class JobEditor: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    static let segueID = "toJobEditor"
    
    @IBOutlet weak var addTask: UIButton!
    private var job: Job?
    let cellReuseIdentifier = "JobEditorCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleValue: UILabel!
    var tappedTableRow: Task!
    var data: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobEditor")
        tableView.delegate = self
        tableView.dataSource = self
        data = "nope"
    print(data)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        addTask.addTarget(self, action: #selector(JobEditor.createTask), for: .touchUpInside)
        if let validJob = job {
            // Set up the default Job
            titleValue.text = validJob.title
            
        } else {
            // Set up an empty job
            titleValue.text = "not valid"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let validJob = self.job {
            self.job = validJob.getJob(jobID: validJob.ID)
        } else {
            print("doesn't have valid jbo")
        }
    }
    
    
    //override func viewWillAppear(_ animated: Bool) {
    //    self.viewDidLoad()
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setJob(job: Job?) {
        print("setJob called")
        self.job = job ?? Job.init()
    }
    
    @objc func createTask() {
        tappedTableRow = nil
         performSegue(withIdentifier: TaskManager.segueID, sender: self)
    }
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TaskManager.segueID {
            let vc = segue.destination as! TaskManager
            // If there is a default job to set then it will set it
            vc.setTask(job: self.job!, task: tappedTableRow)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return job?.tasks.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        // This is where the descripion of the UItableView
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedTableRow = job?.tasks[indexPath.row]
        performSegue(withIdentifier: TaskManager.segueID, sender: self)
    }
    
}

