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
        
        for task in job.getTasks()
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
       
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
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
        
        guard previousIndex >= 0          else { return pages.last }
        
        guard pages.count > previousIndex else { return nil        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
}

extension JobViewer: UIPageViewControllerDelegate { }


