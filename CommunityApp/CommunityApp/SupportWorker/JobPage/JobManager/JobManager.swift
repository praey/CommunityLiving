//
//  JobManager.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-08.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class JobManager: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    var jobs: [Job] = []
    var tappedCollectionCell: Job?
 
    
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        jobs = CoreData.getJobs()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        
        
        
        
        cell.backgroundColor = UIColor.black
        
        //cell.textLabel?.text = self.jobs[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedCollectionCell = jobs[indexPath.row]
        performSegue(withIdentifier: "CellToJobEditor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellToJobEditor" {
            let vc = segue.destination as! JobEditor
            // If there is a default job to set then it will set it
            vc.setJob(job: tappedCollectionCell)
        }
        print("Segue")
    }
    
    
    
    
    
    
}




