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
    @IBOutlet weak var innerView: UIView!
    
    let cellReuseIdentifier = Constant.cellReuseIdentifier
   
    
    @IBOutlet weak var addEvent: UIButton!
    @IBOutlet weak var delete: UIButton!
    
    @IBOutlet weak var taskTableView: UITableView!

    @IBOutlet weak var titleValue: UITextField!

    var tappedTableRow: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobEditor")
        self.hideKeyboardWhenTappedAround()
        disableJob.isOn = job.disabelJob
        self.navigationItem.title = "Job Editor"
        
        addTask = UIBarButtonItem.init(title: "Add Task", style: .plain, target: self, action: #selector(JobEditor.createTask))
        self.navigationItem.rightBarButtonItem = addTask
        
        innerView.layer.cornerRadius = 9
        delete.layer.cornerRadius = 9
        addEvent.layer.cornerRadius = 9
        
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
    
    @IBAction func deleteJob() {
        let alert = UIAlertController(title: "Warning!", message: "Are you sure to delete this job?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            CoreDataManager.database.deleteJob(job: self.job)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
  
    override func viewWillDisappear(_ animated: Bool) {
            recordJob()
    }
    
    func recordJob() {
        job.title = titleValue.text
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
        
        
        let prevView =  cell.contentView.subviews
        for view in prevView {
            view.removeFromSuperview()
        }
        
        
          let textView = UILabel()
        textView.frame = cell.contentView.bounds
        // textView.isEditable = false
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2
        
        
        if let title = job.getTask(row: indexPath.item, include: true).title {
            if title != "" {
              cell.textLabel?.text = String.init(describing: title)
            } else {
                 cell.textLabel?.text = "no title".description
            }
          // cell.contentView.addSubview(textView)
    
        } else {
                 textView.text = "no title"
     cell.textLabel?.text = "no title".description
      //      cell.contentView.addSubview(textView)
            
    
        }
    
        
        
        // cell.textLabel?.text = job.getTask(row: indexPath.row, include: true).title ?? "NO TITLE"
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
    
        editTask(task: job.getTask(row: indexPath.row, include: true))
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



















