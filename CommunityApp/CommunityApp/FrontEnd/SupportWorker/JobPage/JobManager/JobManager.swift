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
    
    var configure: UIBarButtonItem!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var addJob: UIButton!
    var jobs: [Job]!
    var tappedCollectionCell: Job?

    let cellReuseIdentifier = Constant.cellReuseIdentifier
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobManager")
        configure = UIBarButtonItem.init(title: "Configure", style: .plain, target: self, action: #selector(JobManager.toConfigure))
        self.navigationItem.rightBarButtonItem = configure
        addJob.addTarget(self, action: #selector(JobManager.createJob), for: .touchUpInside)
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        jobs = CoreDataManager.database.getJobs()
        collectionView.reloadData()
    }
    
    @objc func createJob(sender: UIButton) {
        if (jobTitle.text?.isEmpty)! {
            print("Job title is empty!")
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
            let textView = UITextView.init()
            textView.text = title
            textView.frame = cell.contentView.bounds
            textView.isEditable = false
            textView.isMultipleTouchEnabled = true
            //textView.touc
            //cell.contentView.addSubview(textView)
        } else {
            let textView = UITextView.init()
            textView.text = "There is no title or picture"
            textView.frame = cell.contentView.bounds
            //cell.contentView.addSubview(textView)
        }
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
       
        editJob(job: jobs[indexPath.row])
    }
}




