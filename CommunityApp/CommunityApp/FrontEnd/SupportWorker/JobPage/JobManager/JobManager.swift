//
//  JobManager.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-08.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class JobManager: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    static let segueID = "toJobManager"

    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var addJob: UIButton!
    var jobs: [Job]!
    var tappedCollectionCell: Job?

    let cellReuseIdentifier = "cellReuseIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobManager")
        
        addJob.addTarget(self, action: #selector(JobManager.createJob), for: .touchUpInside)
    
        
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        jobs = CoreDataManager.database.getJobs()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @objc func createJob(sender: UIButton) {
        if (jobTitle.text?.isEmpty)! {
            print("Job title is empty!")
        }
        else {
            tappedCollectionCell = CoreDataManager.database.createJob(title: jobTitle.text!)
            performSegue(withIdentifier: JobEditor.segueID, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == JobEditor.segueID {
            let vc = segue.destination as! JobEditor
            // If there is a default job to set then it will set it
            vc.job = tappedCollectionCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        // This is where the descripion of the UICollectionView
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedCollectionCell = jobs[indexPath.row]
        performSegue(withIdentifier: JobEditor.segueID, sender: self)
    }
    
}






