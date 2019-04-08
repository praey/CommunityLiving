//
//  ViewController.swift
//  coreDataAndFileSystem
//
//  Created by Tianyuan Zhang on 2018/5/15.
//  Copyright © 2018年 Tianyuan Zhang. All rights reserved.
//

import UIKit

class Page2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let coreDataManager: CoreDataManager = CoreDataManager.database
    var imagePickerController: UIImagePickerController!
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
//        coreDataManager.setTask(job: passedInfo, name: nameText.text!, id: idText.text!, jobid: passedInfo.id!)
//        nameText.text = ""
//        idText.text = ""
    }
    
    @IBAction func readButton(_ sender: Any) {
        let task = coreDataManager.getTask(job: passedInfo, id: idText.text!)
        if task == nil {
            idText.text = "not exist"
            imageView.image = nil
        }
        else {
            nameText.text = task?.title!
            if task?.disablePhoto == false{
                imageView.image = coreDataManager.fileSystemManager.getImage(task: task!)
            }
        }
    }
    
    @IBAction func deletAllButton(_ sender: Any) {
        imageView.image = nil
        coreDataManager.deleteAllTasks(job: passedInfo)
    }
    
    @IBAction func getIDButton(_ sender: Any) {
        print(coreDataManager.getTaskID(job: passedInfo))
    }
    
    @IBAction func chooseImageButton(_ sender: Any) {
        let task = coreDataManager.getTask(job: passedInfo, id: idText.text!)
        if task != nil{
            imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        coreDataManager.setTaskPhoto(jobID: passedInfo.id!, taskID: idText.text!, photo: imageView.image!)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
}

