//
//  TaskManager.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-08.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import MediaPlayer

class TaskManager: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MPMediaPickerControllerDelegate{
    static let segueID = "toTaskManager"
    
    private var imagePickerController: UIImagePickerController!
    private var mediaPickerController: MPMediaPickerController!
    
    var task: Task!
    //var job: Job!
    
    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var taskSaveButton: UIButton!
    

    @IBOutlet weak var textValue: UITextField!
    let cellReuseIdentifier = "cell"
    
    var data: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered TaskManager")
        taskSaveButton.addTarget(self, action: #selector(TaskManager.saveTask), for: .touchUpInside)
        titleValue.text = task.title
        textValue.text = self.task.text ?? "default text"
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAudioTaker" {
            let vc = segue.destination as! AudioRecorderManager
            // If there is a default job to set then it will set it
            vc.task = task
        }
    }
    
//    func setTask(job: Job, task: Task?) {
//        self.job = job
//        self.task = task ?? CoreDataManager.database.createTask(job: self.job, title: "default task")
//    }
    
    @objc func saveTask() {
       task.title = titleValue.text!
        self.navigationController?.popViewController(animated: true)
       
        
    }
    
    
    func setText() {
         task.text = textValue.text!
    }
    
    
    
    
    
    @IBAction func textDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            task.disableText = sender.isOn
            print("text switched")
        }
        print("actived button")
        
    }
    
    @IBAction func photoDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            task.disablePhoto = sender.isOn
        }
    }
    
    @IBAction func videoDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            task.disableVideo = sender.isOn
        }
    }
    
    @IBAction func audioDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            task.disableAudio = sender.isOn
        }
    }
    
  
    @IBAction func galleryPhoto(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Camera does not exist!", message: "Please check your camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func galleryAudio(_ sender: Any) {
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.allowsPickingMultipleItems = false
        present(mediaPickerController, animated: true, completion: nil)
    }

    @IBAction func takeVideo(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            imagePickerController.videoQuality = .typeMedium
            imagePickerController.videoMaximumDuration = 15
            present(imagePickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Camera does not exist!", message: "Please check your camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func galleryVideo(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPickerController: MPMediaPickerController) {
        mediaPickerController.dismiss(animated: true, completion: nil)
    }

    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == "public.image" {
            CoreDataManager.database.setTaskPhoto(task: task, photo: info[UIImagePickerControllerOriginalImage] as! UIImage)
        }
        if mediaType == "public.movie" {
            CoreDataManager.database.setTaskVideo(task: task, videoURLString: (info[UIImagePickerControllerMediaURL] as! NSURL).path!)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    @objc func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            for item in mediaItemCollection.items{
                let mediaURL = item.assetURL!
                print("\(mediaURL)")
                CoreDataManager.database.setTaskAudio(task: task, audioURLString: "\(mediaURL)")
        }
    }
    

}













