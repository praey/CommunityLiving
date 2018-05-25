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

    @IBOutlet weak var addJob: UIButton!

   
    var jobs: [Job]!
    var tappedCollectionCell: Job?

    let cellReuseIdentifier = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobManager")
    
        jobs = CoreData.tempJob
        addJob.addTarget(self, action: #selector(JobManager.createJob), for: .touchUpInside)
        
        
        if let backBar = self.navigationItem.backBarButtonItem {
            
            print("was set")
            backBar.target = self
            backBar.action = #selector(JobManager.toRootView)
            
        }else {
            print("wasn't set")
        }
        
        self.navigationItem.backBarButtonItem?.title = "hello"
        
        if let backBar = self.navigationItem.leftBarButtonItem {
          
            print("was set")
            backBar.target = self
            backBar.action = #selector(JobManager.toRootView)
            
            
        } else {
            print("Back bar wasn't set")
        }
        
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func toRootView() {
        if let nav = self.navigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    
    @objc func createJob(sender: UIButton) {
        tappedCollectionCell = nil
        performSegue(withIdentifier: JobEditor.segueID, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJobEditor" {
            let vc = segue.destination as! JobEditor
            // If there is a default job to set then it will set it
            vc.setJob(job: tappedCollectionCell!)
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





