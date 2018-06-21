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

class TaskManager: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    static let segueID = "toTaskManager"
    
     private var imagePickerController : UIImagePickerController!
    
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
        
        if let title = task.title {
            titleValue.text = title
            print("Task manager title wasn't set and it is mandatory that it has a value")
        }
        if let text = task.text {
            textValue.text = text
        }
        if task.ifFileExists(filePath: .audio) {
            
        }
        
        if task.ifFileExists(filePath: .photo) {
            
        }
        if task.ifFileExists(filePath: .video) {
            
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func saveTask() {
        setText()
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
    
    
    }
    
    @IBAction func takeAudio(_ sender: Any) {
        
        
    }
    @IBAction func takeVideo(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.videoQuality = .typeLow
            // I don't think we should force them to have 15 seconds anymore
            // imagePickerController.videoMaximumDuration = 15
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
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
    

}

extension TaskManager: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("called the text field delegate")
        if let text = textField.text {
            if text.isEmpty {
               task.text = nil
            } else {
                task.text = text
            }
        }
        
    }
}












