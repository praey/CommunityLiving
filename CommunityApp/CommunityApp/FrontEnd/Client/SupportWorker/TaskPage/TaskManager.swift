//
//  TaskManager.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-08.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class TaskManager: UIViewController, UINavigationControllerDelegate {
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
        
        navigationController?.delegate = self
        data = ["The data has changed"]
        
        // this is where I set up the default task
        if let text = self.task.text {
            textValue.text = text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func setTask(job: Job, task: Task?) {
        self.job = job
        self.task = task ?? Task.init(job: self.job)
    }
    
    @objc func saveTask() {

        if let text = textValue.text {
            task.setText(text: text)
            print("Saved the task")
        }   else {
            print("didn't have a valid Text")
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == JobEditor.segueID {
            let vc = segue.destination as! JobEditor
            vc.setJob(job: self.task.job)
        }
    }
    

    

    
    

    
    

}


extension TaskManager {
/*
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animaged: Bool) {
        if let controller = viewController as? JobEditor {
            controller.data = "it worked"
            controller.setJob(job: nil)
        } else {
            print("controller isn't a jobeditor")
        }
    }*/
}














