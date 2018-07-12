//
//  JobEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import EventKitUI
class JobEditor: UIViewController  {
    
    var addTask: UIBarButtonItem!

    @IBOutlet weak var disableJob: UISwitch!
    var job: Job!

    let cellReuseIdentifier = Constant.cellReuseIdentifier
   
    
    @IBOutlet weak var taskTableView: UITableView!

    @IBOutlet weak var titleValue: UITextField!

    var tappedTableRow: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobEditor")
        self.hideKeyboardWhenTappedAround()
        disableJob.isOn = false//job.disableJob
        
        addTask = UIBarButtonItem.init(title: "Add Task", style: .plain, target: self, action: #selector(JobEditor.createTask))
        self.navigationItem.rightBarButtonItem = addTask
        
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
       
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
       //  taskTableView.isEditing = true
        
        if let title = job.title {
            titleValue.text = title
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.job = CoreDataManager.database.getJob(jobID: job.id!)
        taskTableView.reloadData()
        
    }

    @objc func createTask() {
       tappedTableRow = CoreDataManager.database.createTask(job: job)
        performSegue(withIdentifier: Constant.segueID.TaskManager, sender: self)
    }
    
    func editTask(task: Task) {
        tappedTableRow = task
        performSegue(withIdentifier: Constant.segueID.TaskManager, sender: self)
    }
    
  
    
    @objc func recordJob() {
        
       job.disabelJob = disableJob.isOn
        CoreDataManager.database.saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.TaskManager {
            let vc = segue.destination as! TaskManager
            vc.task = tappedTableRow
        } else if segue.identifier == Constant.segueID.NotificationController {
            let vc = segue.destination as! NotificationController
            vc.setJob(job: self.job)
        }
    }
}


extension JobEditor: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return job.has!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.taskTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        // This is where the descripion of the UItableView
        cell.backgroundColor = UIColor.orange
        
        cell.textLabel?.text = job.getTask(row: indexPath.row, include: true).title ?? "NO TITLE"
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
    
        editTask(task: job.getTask(row: indexPath.row, include: true))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "This should be the title of the Job \(job.title!)"
    }
    
    
    
   // func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
   //     return .none
   // }
    
    
    
  //  func tableView(_ tableView: UITableView, /shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
      //  return false
   // }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       // let movedTask = self.job.getTask(row: sourceIndexPath.row, include: true)
        // CoreDataManager.database.setTaskPosition(task: movedTask, oldPos: sourceIndexPath.row, newPos: destinationIndexPath.row)
        
        print(
            "Moved \(sourceIndexPath.row) to \(destinationIndexPath.row)" + self.job.getTask(row: sourceIndexPath.row, include: true).title!)
        // To check for correctness enable: self.tableView.reloadData()
    }
    
}



















