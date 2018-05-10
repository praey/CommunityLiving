//
//  TaskEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class TaskEditor: UIViewController {
    
   
    
    var task: Task?
    
    
    @IBOutlet weak var taskSave: UIButton!
    @IBOutlet weak var taskDisabled: UISwitch!
    
    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textValue: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    // @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let validTask = task {
            taskDisabled.isOn = validTask.isDisabled
            
            titleValue.text = validTask.title
            textValue.text = validTask.text
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTask(task: Task) {
        print("Set Task")
        self.task?.assign(task: task)
    }
    
    
    @IBAction func saveTask () {
        
        
        task = Task(title: titleValue.text!,text: textValue.text!)
        print("Saved Task")
        // save task to Core Data
        
        performSegue(withIdentifier: "JobEditor", sender: self)
        print("Return to JobEditor")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "JobEditor" {
            segue.destination as! JobEditor
        }
    }
    
    
    
}
