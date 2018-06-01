//
//  Page1.swift
//  coreDataAndFileSystem
//
//  Created by Tianyuan Zhang on 2018/5/22.
//  Copyright © 2018年 Tianyuan Zhang. All rights reserved.
//

import UIKit

class Page1: UIViewController {
    
    let coreDataManager = CoreDataManager.coreDataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Page2 {
            vc.passedInfo = coreDataManager.getJob(id: idText.text!)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "selectSegue" {
            return false
        }
        else {return true}
    }
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var idText: UITextField!
    
    @IBAction func selectButton(_ sender: Any) {
        if idText.text != "" && coreDataManager.getJob(id: idText.text!) != nil {
            performSegue(withIdentifier: "selectSegue", sender: self)
        }
        else if idText.text == "" {
            idText.text = "Id is empty!"
        }
        else {
            idText.text = "Job not exist"
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if idText.text! == "" || nameText.text! == "" {
            idText.text = "Enter Name"
            nameText.text = "Enter ID"
        }
        else{
            coreDataManager.setJob(id: idText.text!, name: nameText.text!)
        }
    }
    
    @IBAction func deletAllButton(_ sender: Any) {
        coreDataManager.deletAllJobs()
    }
    
    @IBAction func getJob(_ sender: Any){
        let job = coreDataManager.getJob(id: idText.text!)
        if job == nil {
            idText.text = "not exist!"
        }
        else {
            nameText.text = job?.title
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

