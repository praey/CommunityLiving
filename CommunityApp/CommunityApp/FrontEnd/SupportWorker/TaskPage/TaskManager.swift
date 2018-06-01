//
//  TaskManager.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-08.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class TaskManager: UIViewController {
    static let segueID = "toTaskManager"
    
    var task: Task!
    var job: Job!
    
    @IBOutlet weak var taskSaveButton: UIButton!
    
    
    @IBOutlet weak var textValue: UITextField!
    let cellReuseIdentifier = "cell"
    
    var data: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered TaskManager")
        taskSaveButton.addTarget(self, action: #selector(TaskManager.saveTask), for: .touchUpInside)
        
        textValue.text = self.task.text ?? "default text"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setTask(job: Job, task: Task?) {
        self.job = job
        self.task = task! // ?? CoreDataManager.database.createTask(job: self.job)
    }
    
    @objc func saveTask() {

//        if CoreDataManager.database.saveTask(task: self) {
//            print("saved task")
//        } else {
//            print("didn't save task")
//        }
//        
        // After it save you go back to the previous screen
        self.navigationController?.popViewController(animated: true)
        
        
    }
}













