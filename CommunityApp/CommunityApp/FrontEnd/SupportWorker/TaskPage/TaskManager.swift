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
    
    let validInput: UIImage = UIImage.init(named: "yes")!// UIColor.green
    let invalidInput: UIImage = UIImage.init(named: "no")!// UIColor.red


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
        setUp()
        self.hideKeyboardWhenTappedAround()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if task.ifFileExists(filePath: .audio) {
            disableAudio.isEnabled = true
            disableAudio.isOn = false
            validAudio.image = validInput
        }
    }
    
    func setUp() {
        
        disableTask.isOn = task.disableTask
        disableText.isOn = task.disableText
        disableAudio.isOn = task.disableAudio
        disablePhoto.isOn = task.disablePhoto
        disableVideo.isOn = task.disableVideo
        
        textValue.delegate = self

        textValue.text = task?.text ?? ""
        
        
        
        validText.image = task.text != nil ? validInput : invalidInput
        validAudio.image = task.ifFileExists(filePath: .audio) ? validInput: invalidInput
        validPhoto.image = task.ifFileExists(filePath: .photo) ? validInput: invalidInput
        validVideo.image = task.ifFileExists(filePath: .video) ? validInput: invalidInput
        

        disableText.isEnabled = task.text != nil
        disableAudio.isEnabled = task.ifFileExists(filePath: .audio)
        disableVideo.isEnabled = task.ifFileExists(filePath: .video)
        disablePhoto.isEnabled = task.ifFileExists(filePath: .photo)
        
    }
    
    
 
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.AudioRecorder {
            let vc = segue.destination as! AudioRecorderManager
            // If there is a default job to set then it will set it
            vc.task = task
        }
    }

    



    func setDown() {
        task.disableTask = disableTask.isOn
        task.disableText = disableText.isOn
        task.disableAudio = disableAudio.isOn
        task.disablePhoto = disablePhoto.isOn
        task.disableVideo = disableVideo.isOn
    }
    
 
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
     setDown()
        
        
        
        CoreDataManager.database.saveData()
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let alert = UIAlertController(title: "Warning!", message: "Are you sure to delete this task?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            CoreDataManager.database.deleteTask(task: self.task)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // add one button that will display a test of what the task actuatlly is
    
    @IBAction func viewTaskTemplate() {
        // double checks that all the data is saved
        setDown()
        if let navigationController = self.navigationController, let taskTemplate = task.getTaskTemplate() {
            taskTemplate.isTest(true)
            print("pushed the new tasktemplate")
            navigationController.pushViewController(taskTemplate, animated: true)
        } else {
            print("failed to push task tempalte")
        }
    }

}




// Video and photo
extension TaskManager {
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
                    
                    self.validPhoto.image = self.validInput
                    self.disablePhoto.isEnabled = true
                    self.disablePhoto.isOn = false
                    
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                imagePickerController.dismiss(animated: true, completion: nil)
                present(alert, animated: true, completion: nil)
            }
            else {
                CoreDataManager.database.setTaskPhoto(task: task, photo: info[UIImagePickerControllerOriginalImage] as! UIImage)
                validPhoto.image = validInput
                disablePhoto.isEnabled = true
                disablePhoto.isOn = false
                imagePickerController.dismiss(animated: true, completion: nil)
            }
        }
        if mediaType == "public.movie" {
            if task.ifFileExists(filePath: .video) {
                let alert = UIAlertController(title: "Warning!", message: "Are you sure to replace the existing video?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                    CoreDataManager.database.setTaskVideo(task: self.task, videoURLString: (info[UIImagePickerControllerMediaURL] as! NSURL).path!)
                    self.validVideo.image = self.validInput
                    self.disableVideo.isEnabled = true
                    self.disableVideo.isOn = false
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                imagePickerController.dismiss(animated: true, completion: nil)
                present(alert, animated: true, completion: nil)
            }
            else {
                
                CoreDataManager.database.setTaskVideo(task: task, videoURLString: (info[UIImagePickerControllerMediaURL] as! NSURL).path!)
                validVideo.image = validInput
                disableVideo.isEnabled = true
                disableVideo.isOn = false
                imagePickerController.dismiss(animated: true, completion: nil)
            }
        }
    }
}




// Video
extension TaskManager {
    // MARK: Video functions
    
    @IBAction func videoDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            task.disableVideo = sender.isOn
            
            if !sender.isOn {
                if task.ifFileExists(filePath: .video) {
                    validVideo.image = validInput
                }
            } else {
                validVideo.image = invalidInput
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
}








// Audio
extension TaskManager {
    
    @IBAction func audioDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            if !sender.isOn {
                if task.ifFileExists(filePath: .audio) {
                    validAudio.image = validInput
                }
            } else {
                validAudio.image = invalidInput
                
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
            CoreDataManager.database.setTaskAudio(task: task, audioURLString: "\(mediaURL)")
            validAudio.image = validInput
        }
        disableAudio.isEnabled = true
        disableAudio.isOn = false
    }
}






// Photo
extension TaskManager {
    // MARK: Photo functions
    
    @IBAction func photoDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            if !sender.isOn {
                if task.ifFileExists(filePath: .photo) {
                    validPhoto.image = validInput
                }
            } else {
                validPhoto.image = invalidInput
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    
}





// Text
extension TaskManager: UITextFieldDelegate {
    
    // MARK: Text functions
    @IBAction func textDisabled(_ sender: Any) {
        if let sender = sender as? UISwitch {
            if !sender.isOn {
                // If there is valid text
                if let text = textValue.text {
                    if !text.isEmpty{
                    validText.image = validInput
                    }
                    
                }
            } else {
                validText.image = invalidInput
            }
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if reason == .committed {
            if let text = textField.text {
                if !text.isEmpty {
                    CoreDataManager.database.setTaskText(task: task, text: text)
                    disableText.isEnabled = true
                    disableText.isOn = false
                    validText.image = validInput
                } else {
                    validText.image = invalidInput
                }
            }
            
        }
        
    }

}
















