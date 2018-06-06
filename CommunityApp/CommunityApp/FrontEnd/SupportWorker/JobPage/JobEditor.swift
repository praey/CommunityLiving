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
    private var job: Job!
    let cellReuseIdentifier = "JobEditorCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleValue: UITextField!
    var tappedTableRow: Task!
    var data: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobEditor")
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        addTask.addTarget(self, action: #selector(JobEditor.createTask), for: .touchUpInside)
       
        
        if let title = job.title {
            titleValue.text = title
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.job = CoreDataManager.database.getJob(jobID: job.id!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setJob(job: Job?) {
        self.job = job ?? CoreDataManager.database.createJob(title: "Wanted to add new job")
    }
    
    @objc func createTask() {
        tappedTableRow = nil
         performSegue(withIdentifier: TaskManager.segueID, sender: self)
    }
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TaskManager.segueID {
            let vc = segue.destination as! TaskManager
            // If there is a default job to set then it will set it
            vc.setTask(job: self.job, task: tappedTableRow)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return job.has!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        // This is where the descripion of the UItableView
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedTableRow =  job.getTask(row: indexPath.row)
        performSegue(withIdentifier: TaskManager.segueID, sender: self)
    }
    
}

