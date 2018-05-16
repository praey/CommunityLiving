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
        
        var task: Task?
        var job: Job!
    @IBOutlet weak var taskSaveButton: UIButton!
    
    
    @IBOutlet weak var textValue: UITextField!
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
            super.viewDidLoad()
        print("Entered TaskManager")
        taskSaveButton.addTarget(self, action: #selector(TaskManager.saveTask), for: .touchUpInside)
        
            if let validTask = self.task {
                // this is where I set up the default task
                textValue.text = validTask.text
            } else {
                // Set up a default task
                self.task = Task.init(job: self.job)
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    
    func setTask(job: Job!, task: Task?) {
        self.job = job
        self.task = task
    }
    
    @objc func saveTask() {

        if let validTask = self.task {
            // validTask.title = titleValue.text
            validTask.text = textValue.text!
            
            // Add task to job
            // Save information to Database
            let validEntry: Bool = CoreData.setTaskText(jobID: self.job.getID(), taskID: validTask.getID(), text: textValue.text!)
            
            if validEntry {
                print("Saved Task")
                self.job.addTask(newTask: validTask)// make sure you select the correct Task
            }
            if let navigation = self.navigationController {
                navigation.popViewController(animated: true)
            }
            // performSegue(withIdentifier: JobEditor.segueID, sender: self)
            
        } else {
            print("didn't have a validTask")
        }
       
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == JobEditor.segueID {
            let vc = segue.destination as! JobEditor
            vc.setJob(job: self.job)
        }
    }
    
}
    
    
    
    
    


    
    
    
    
    
    
