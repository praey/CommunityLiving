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
        self.navigationItem.title = "Job Selector"
        
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
            
            if (self.jobs.count == 0) {
  /*              let button = UIButton.init(frame: (self.collectionView?.frame)!)
                self.collectionView?.addSubview(button)
                button.addTarget(self, action: #selector(JobSelector.goToJobManager), for: .touchUpInside)
*/
                self.collectionView?.setEmptyMessage("No data found. Go back to the previous page and double click the Support Worker button to add a job.")
            } else {
                self.collectionView?.restore()
            }

        print("Jobs Count: " + jobs.count.description)
        return jobs.count
    }
    
    @objc func goToJobManager() {
       // self.navigationController?.popToRootViewController(animated: true)
       // self.navigationController?.push
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: UICollectionViewCell = self.collectionView!.getCell(cellReuseIdentifier, indexPath: indexPath, job: jobs[indexPath.row])
            
        
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

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Avenir-Light", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
    func getCell(_ cellReuseIdentifier: String, indexPath: IndexPath, job: Job) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = self.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        //removes content within cell
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        // This is where the descripion of the UICollectionView
        // Attempt to show a picture in the box
        let image: UIImage? = job.thumbnail
        let title: String? = job.title
        if let image = image {
            let imageView = UIImageView.init(image: image)
            imageView.frame = cell.contentView.bounds
            cell.contentView.addSubview(imageView)
            
        } else if let title = title {
            let textView = UILabel()
            textView.text = title
            textView.textAlignment = .center
            textView.frame = cell.contentView.bounds
            
            textView.backgroundColor = UIColor.cyan
            textView.layer.borderColor = UIColor.black.cgColor
            textView.layer.borderWidth = 2
            cell.contentView.addSubview(textView)
        } else {
            
            let imageView = UIImageView.init(image: UIImage.init(named: "Icon"))
            imageView.frame = cell.contentView.bounds
            cell.contentView.addSubview(imageView)
            
        }
        
        return cell
        
    }
    
    
    
}
extension UICollectionView {

   
   
    
    
    
    

    
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









