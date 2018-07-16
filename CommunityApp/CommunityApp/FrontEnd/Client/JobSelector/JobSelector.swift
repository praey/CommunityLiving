//
//  JobSelector.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-16.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit


class JobSelector: UICollectionViewController {
    var jobs: [Job] = []
    let cellReuseIdentifier: String = Constant.cellReuseIdentifier
    var tappedTableRow: Job!
    let itemsPerRow = 5

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        jobs = CoreDataManager.database.getJobs(include: false)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView!.setCollectionViewLayout(Constant.collectionViewLayout, animated: true)
        collectionView!.delegate = self
        collectionView!.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.JobViewer {
            let vc = segue.destination as! JobViewer
            // If there is a default job to set then it will set it
            vc.setJob(job: tappedTableRow)
           
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Jobs Count: " + jobs.count.description)
        return jobs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: UICollectionViewCell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
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
            textView.backgroundColor = UIColor.gray
            cell.contentView.addSubview(textView)
        } else {
            let textView = UILabel()
            textView.text = "There is no title or picture"
            textView.backgroundColor = UIColor.gray
            textView.frame = cell.contentView.bounds
            cell.contentView.addSubview(textView)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedTableRow = jobs[indexPath.row]
        if shouldSegue(tappedTableRow) {
         
            performSegue(withIdentifier: Constant.segueID.JobViewer, sender: self)
            
        }
        
    }
    
    func shouldSegue(_ job: Job) -> Bool {
        // get's all valid tasks
        let tasks = job.getTasks(include: false).filter {$0.getTaskType().count > 0}
        return tasks.count > 0
        
    }
    
    
    
}
class CollectionLayout: UICollectionViewFlowLayout {
    
    
   
    /*
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
    }
    
    override func prepare() {
        super.prepare()
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
    }
     */
    
    //collectionViewContentSize
    //layoutAttributesForElements(in:)
    //layoutAttributesForItem(at:)
    //layoutAttributesForSupplementaryView(ofKind:at:) (if your layout supports supplementary views)
    //layoutAttributesForDecorationView(ofKind:at:) (if your layout supports decoration views)
    //shouldInvalidateLayout(forBoundsChange:)
}









