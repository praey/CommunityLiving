//
//  JobTemplate.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-15.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation

import UIKit

class JobViewer: UIPageViewController
{
    fileprivate var job: Job!
    fileprivate lazy var pages: [UIViewController] = {
    var controllers: [UIViewController] = []
        
        for task in job.getTasks(include: false)
        {
           var viewController: TaskTemplate? = task.getTaskTemplate()
            guard let vc = viewController else {
                continue
            }
            controllers.append(vc)
            print("Added task")
        }
        return controllers
    }()
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        
        self.navigationItem.title = "Job Viewer"
       
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        print("Pages Count: \(pages.count)")
        
        //UIPageViewControllerTransitionStyle
    }
    
    func setJob(job: Job) {
        print("JobViewer: Job was set")
        self.job = job
    }
    /*
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        let transitionStyle = UserDefaults.standard.object(forKey: "pageControllerTransition") as! UIPageViewController.TransitionStyle
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }*/
    //override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [NSObject : AnyObject]!) {
     //   super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: options as! [String : Any])
    //}
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension JobViewer: UIPageViewControllerDataSource
{
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        //if you are out of the array
        guard previousIndex >= 0          else {
            if previousIndex + pages.count == viewControllerIndex {
            return nil
            }
            return pages.last
            
        }
        // if you are not going backwards
        guard pages.count > previousIndex else { return nil        }
        // if it's the same page
        guard pages[previousIndex] != viewController else {return nil}
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        
        // when it is past the last one you will pop the view controller
        // when 20 min past go back to jobSelector
 
        
        
         guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        
        
        // if you are out of the array return to the first page
        guard nextIndex < pages.count else {
          
                
                for vc in (self.navigationController?.viewControllers)! {
                    if let vc = vc as? JobSelector {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                }
                
                //if(self.navigationController?.viewControllers[i].isKindOfClass(YourDesiredViewController) == true) {
                //self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! DestinationViewController, animated: true)

                
                
               // dismiss(animated: true, completion: nil)
                return nil
           
            }
        
        
      
        
        
        // makes sure you are in the array
        guard pages.count > nextIndex else { return nil         }
        // makes sure it's not the same page
        guard pages[nextIndex] != viewController else {return nil}
        
        return pages[nextIndex]
    }
}

extension JobViewer: UIPageViewControllerDelegate { }




