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
        
        collectionView.setCollectionViewLayout(Constant.collectionViewLayout, animated: true)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        jobs = CoreDataManager.database.getJobs(include: true)
        collectionView.reloadData()
    }

    @objc func toEmail() {
         performSegue(withIdentifier: Constant.segueID.EmailPage, sender: self)
    }
    @objc func createJob(sender: UIButton) {
        if (jobTitle.text?.isEmpty)! {
            print("Job title is empty!")
            // Create action
            let alert = UIAlertController(title: "Warning!", message: "You must add a title to the Job that you are attempting to add.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else {
            tappedCollectionCell = CoreDataManager.database.createJob(title: jobTitle.text!)
            performSegue(withIdentifier: Constant.segueID.JobEditor, sender: self)
        }
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
        
        let cell: UICollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        
        // This is where the descripion of the UICollectionView
        // Attempt to show a picture in the box
        let image: UIImage? = jobs[indexPath.row].thumbnail
        let title: String? = jobs[indexPath.row].title
        if let image = image {
            let imageView = UIImageView.init(image: image)
            imageView.frame = cell.contentView.bounds
            cell.contentView.addSubview(imageView)

        } else if let title = title {
            let textView = UILabel()
            textView.text = title
            textView.frame = cell.contentView.bounds
           // textView.isEditable = false
            textView.layer.borderColor = UIColor.black.cgColor
            textView.layer.borderWidth = 2
            cell.contentView.addSubview(textView)
        } else {
            let textView = UILabel()
            textView.text = "There is no title or picture"
            textView.backgroundColor = UIColor.gray
            textView.frame = cell.contentView.bounds
            textView.layer.borderColor = UIColor.black.cgColor
            textView.layer.borderWidth = 2
            cell.contentView.addSubview(textView)
        }
        // cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
       
        editJob(job: jobs[indexPath.row])
    }
}




