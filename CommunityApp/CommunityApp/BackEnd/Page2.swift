//
//  ViewController.swift
//  coreDataAndFileSystem
//
//  Created by Tianyuan Zhang on 2018/5/15.
//  Copyright © 2018年 Tianyuan Zhang. All rights reserved.
//

import UIKit

class Page2: UIViewController {
    
    let coreDataManager: CoreDataManager = CoreDataManager.database
    var passedInfo: Job!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataManager.fileSystemManager.createImageFolder()
        coreDataManager.fileSystemManager.createVideoFolder()
        coreDataManager.fileSystemManager.createAudioFolder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var idText: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        coreDataManager.saveData(job: passedInfo, name: nameText.text!, id: idText.text!, jobid: passedInfo.id!)
        nameText.text = ""
        idText.text = ""
    }
    
    @IBAction func readButton(_ sender: Any) {
//        let task = coreDataManager.retrieveTask(job: passedInfo, id: idText.text!)
//        if task == nil {
//            idText.text = "not exist"
//            imageView.image = nil
//        }
//        else {
//            nameText.text = task?.title!
//            imageView.image = coreDataManager.fileSystemManager.getImage(task: task!)
//        }
    }
    
    @IBAction func deletAllButton(_ sender: Any) {
        imageView.image = nil
        coreDataManager.deleteAllTasks(job: passedInfo)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
}

