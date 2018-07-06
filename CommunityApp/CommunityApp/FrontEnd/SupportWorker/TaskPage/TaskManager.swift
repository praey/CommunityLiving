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

class TaskManager: UIViewController, UIImagePickerControllerDelegate, MPMediaPickerControllerDelegate, UINavigationControllerDelegate {
    
    
    private var imagePickerController: UIImagePickerController!
    private var mediaPickerController: MPMediaPickerController!
    var task: Task!


    @IBOutlet weak var validVideo: UIImageView!
    
    @IBOutlet weak var validAudio: UIImageView!
    
    @IBOutlet weak var validPhoto: UIImageView!
    @IBOutlet weak var validText: UIImageView!
    @IBOutlet weak var textValue: UITextField!
    
    @IBOutlet weak var disablePhoto: UISwitch!
    @IBOutlet weak var disableText: UISwitch!
    @IBOutlet weak var disableTask: UISwitch!
    
    @IBOutlet weak var disableVideo: UISwitch!
    @IBOutlet weak var disableAudio: UISwitch!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered TaskManager")

        disableTask.isOn = task.disableTask
        disableText.isOn = task.disableText
        disableAudio.isOn = task.disableAudio
        disablePhoto.isOn = task.disablePhoto
        disableVideo.isOn = task.disableVideo
        
        textValue.delegate = self
        
        
        if let text = task.text {
            textValue.text = text
            validText.backgroundColor = UIColor.green
        } else {
            validText.backgroundColor = UIColor.red
        }

        if task.ifFileExists(filePath: .audio) {
            validAudio.backgroundColor = UIColor.green
        } else {
            validAudio.backgroundColor = UIColor.red
        }
        
        if task.ifFileExists(filePath: .photo) {
            validPhoto.backgroundColor = UIColor.green
        } else {
            validPhoto.backgroundColor = UIColor.red
        }
        
        if task.ifFileExists(filePath: .video) {
            validVideo.backgroundColor = UIColor.green
        } else {
            validVideo.backgroundColor = UIColor.red
        }
    }
    
    // add one button that will display a test of what the task actuatlly is
    
    @IBAction func viewTaskTemplate() {
        if let navigationController = self.navigationController, let taskTemplate = task.getTaskTemplate() {
            print("pushed the new tasktemplate")
            navigationController.pushViewController(taskTemplate, animated: true)
        } else {
            print("failed to push task tempalte")
        }
        
        
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.AudioRecorder {
            let vc = segue.destination as! AudioRecorderManager
            // If there is a default job to set then it will set it
            vc.task = task
        }
    }

    
    // MARK: Text functions
    @IBAction func textDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            if sender.isOn {
                // If there is valid text
                if !(textValue.text?.isEmpty)! {
                    validVideo.backgroundColor = UIColor.green
                }
            } else {
                validVideo.backgroundColor = UIColor.red
            }
        }
    }
    // MARK: Photo functions
    
    @IBAction func photoDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            if sender.isOn {
                if task.ifFileExists(filePath: .photo) {
                    validPhoto.backgroundColor = UIColor.green
                }
            } else {
                validPhoto.backgroundColor = UIColor.red
            }
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
    
    
    // MARK: Audio functions
    
    @IBAction func audioDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            if sender.isOn {
                if task.ifFileExists(filePath: .audio) {
                    validAudio.backgroundColor = UIColor.green
                }
            } else {
                validAudio.backgroundColor = UIColor.red
            }
        }
    }
    
  
    @IBAction func galleryAudio(_ sender: Any) {
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.allowsPickingMultipleItems = false
        present(mediaPickerController, animated: true, completion: nil)
    }
    
    @objc func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        for item in mediaItemCollection.items{
            let mediaURL = item.assetURL!
            validAudio.backgroundColor = UIColor.green
            disableAudio.isOn = false
            CoreDataManager.database.setTaskAudio(task: task, audioURLString: "\(mediaURL)")
        }
    }
    // MARK: Video functions
    
    @IBAction func videoDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            task.disableVideo = sender.isOn
            
            if sender.isOn {
                if task.ifFileExists(filePath: .video) {
                    validVideo.backgroundColor = UIColor.green
                }
            } else {
                validVideo.backgroundColor = UIColor.red
            }
        }
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
            if task.ifFileExists(filePath: .photo) {
                let alert = UIAlertController(title: "Warning!", message: "Are you sure to replace the exist image?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                    CoreDataManager.database.setTaskPhoto(task: self.task, photo: info[UIImagePickerControllerOriginalImage] as! UIImage)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                imagePickerController.dismiss(animated: true, completion: nil)
                present(alert, animated: true, completion: nil)
            }
            else {
                validPhoto.backgroundColor = UIColor.green
                CoreDataManager.database.setTaskPhoto(task: task, photo: info[UIImagePickerControllerOriginalImage] as! UIImage)
                imagePickerController.dismiss(animated: true, completion: nil)
            }
        }
        if mediaType == "public.movie" {
            if task.ifFileExists(filePath: .video) {
                let alert = UIAlertController(title: "Warning!", message: "Are you sure to replace the exist video?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                    CoreDataManager.database.setTaskVideo(task: self.task, videoURLString: (info[UIImagePickerControllerMediaURL] as! NSURL).path!)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                imagePickerController.dismiss(animated: true, completion: nil)
                present(alert, animated: true, completion: nil)
            }
            else {
                validVideo.backgroundColor = UIColor.green
                CoreDataManager.database.setTaskVideo(task: task, videoURLString: (info[UIImagePickerControllerMediaURL] as! NSURL).path!)
                imagePickerController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        task.disableTask = disableTask.isOn
         task.disableText = disableText.isOn
       task.disableAudio = disableAudio.isOn
        task.disablePhoto = disablePhoto.isOn
        task.disableVideo = disableVideo.isOn
        
        
        
        CoreDataManager.database.saveData()
    }
}

extension TaskManager: UITextFieldDelegate {
    
    
   
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if reason == .committed {
            if (textField.text?.isEmpty)! {
               validText.backgroundColor = UIColor.red
             } else {
                diasableText.isOn = false
            validText.backgroundColor = UIColor.green
            }
            
        }
        
    }

}
















