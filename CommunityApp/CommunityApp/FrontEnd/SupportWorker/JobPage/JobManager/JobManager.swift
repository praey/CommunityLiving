//
//  JobManager.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-08.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class JobManager: UIViewController{
    
    @IBOutlet weak var emailPage: UIButton!
    var addJob: UIBarButtonItem!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var configure: UIButton!
    var jobs: [Job]!
    var tappedCollectionCell: Job?

    let cellReuseIdentifier = Constant.cellReuseIdentifier
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobManager")
        self.navigationItem.title = "Job Manager"
        self.hideKeyboardWhenTappedAround()
        
        addJob = UIBarButtonItem.init(title: "Add Job", style: .plain, target: self, action: #selector(JobManager.createJob))
        self.navigationItem.rightBarButtonItem = addJob
        configure.addTarget(self, action: #selector(JobManager.toConfigure), for: .touchUpInside)
        emailPage.addTarget(self, action: #selector(JobManager.toEmail), for: .touchUpInside)
        
        collectionView.layer.cornerRadius = 9
        collectionView.layer.shadowOffset = CGSize(width: 5, height: 5)
        collectionView.layer.shadowOpacity = 0.7
        collectionView.layer.shadowRadius = 5
        collectionView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        emailPage.layer.cornerRadius = 9
        configure.layer.cornerRadius = 9
        
        collectionView.setCollectionViewLayout(Constant.collectionViewLayout, animated: true)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  collectionView.reloadData()
        jobs = CoreDataManager.database.getJobs(include: true)
        
        collectionView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //collectionView.reloadData()
        //collection
    }

    @objc func toEmail() {
         performSegue(withIdentifier: Constant.segueID.EmailPage, sender: self)
    }
    @objc func createJob(sender: UIButton) {
        var inputText:UITextField = UITextField();
        let alert = UIAlertController.init(title: "New Job", message: "Input the job name", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style:.default) { (action:UIAlertAction) ->() in
            if ((inputText.text) == ""){
                let warningAlert = UIAlertController(title: "Warning!", message: "You must add a title to the Job that you are attempting to add.", preferredStyle: .alert)
                warningAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(warningAlert, animated: true, completion: nil)
            }
            else {
                self.tappedCollectionCell = CoreDataManager.database.createJob(title: inputText.text!)
                self.performSegue(withIdentifier: Constant.segueID.JobEditor, sender: self)
            }
        }
        alert.addAction(ok)
        alert.addAction(UIAlertAction.init(title: "Cancel", style:.cancel))
        alert.addTextField { (textField) in
            inputText = textField
            inputText.placeholder = "Input job name"
        }
        present(alert, animated: true, completion: nil)
        
        
        //        if (jobTitle.text?.isEmpty)! {
        //            print("Job title is empty!")
        //            // Create action
        //            let alert = UIAlertController(title: "Warning!", message: "You must add a title to the Job that you are attempting to add.", preferredStyle: .alert)
        //
        //            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //            present(alert, animated: true, completion: nil)
        //        }
        //        else {
        //            tappedCollectionCell = CoreDataManager.database.createJob(title: jobTitle.text!)
        //            performSegue(withIdentifier: Constant.segueID.JobEditor, sender: self)
        //        }
    }
    
    func editJob(job: Job) {
         tappedCollectionCell = job
        performSegue(withIdentifier: Constant.segueID.JobEditor, sender: self)
    }
    
    @objc func toConfigure(sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constant.segueID.Configure, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.JobEditor {
            let vc = segue.destination as! JobEditor
            // If there is a default job to set then it will set it
            vc.job = tappedCollectionCell
        }
    }
    
}


extension JobManager : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: UICollectionViewCell = self.collectionView.getCell(cellReuseIdentifier, indexPath: indexPath, job: jobs[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
       
        editJob(job: jobs[indexPath.row])
    }
}




