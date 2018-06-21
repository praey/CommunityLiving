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
    static let segueID: String = "toJobViewer"
    
    fileprivate var job: Job!
    fileprivate lazy var pages: [UIViewController] = {
        var controllers: [UIViewController] = []
        
        for task in job.getTasks()
        {
            let taskType = task.getTaskType()
            var viewController: TaskTemplate?
            switch taskType {
                case [.video]:
                    viewController = self.getViewController(withIdentifier: "Video") as! Video
                    print("selected video")
            case [.photo]:
                   viewController = self.getViewController(withIdentifier: "Photo") as! Photo
                   print("Selected Photo")
            case [.audio]:
                viewController = self.getViewController(withIdentifier: "Audio") as! Audio
                print("selected Audio")
            case [.text]:
                viewController = self.getViewController(withIdentifier: "Text") as! Text
                print("selected Text")
            case [.text,.audio]:
                viewController = self.getViewController(withIdentifier: "AudioText") as! AudioText
                print("Selected AudioText")
            case [.video,.audio,.text]:
                viewController = self.getViewController(withIdentifier: "VideoAudioText") as! VideoAudioText
                print("Selected Audio Video Text")
            case [.audio,.text,.photo]:
                viewController = self.getViewController(withIdentifier: "AudioTextPhoto") as! AudioTextPhoto
                print("Selected Audio Text Photo")
            case [.video,.text]:
                viewController = self.getViewController(withIdentifier: "VideoText") as! VideoText
                print("Selected Video Text")
            case [.video,.audio]:
                viewController = self.getViewController(withIdentifier: "VideoAudio") as! VideoAudio
                print("Selected Video Audio")
            case [.audio,.photo]:
                viewController = self.getViewController(withIdentifier: "AudioPhoto") as! AudioPhoto
                print("Selected  Audio Photo")
            case [.photo,.text]:
                viewController = self.getViewController(withIdentifier: "PhotoText") as! PhotoText
                print("Selected photo text")
            case[.photo,.video]:
                print("Selected Photo and Video - not accessible")
            case [.photo,.audio,.video]:
                print("Selected photo audio video - not accessible")
            case [.photo,.text,.video]:
                print("Selecte photo text video - not accessible")
            default :
                print("failed to select type")
                
            }
            if let vc = viewController {
                vc.setTask(task: task)
                controllers.append(vc)
                print("Added task")
            }
           
            // If the task is disabled then skip it
            // guard task.isDisabled.contains(.Task)  else {continue}
           
            
        }
        return controllers
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
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

/*
class JobTemplate: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
    }
}

// MARK: UIPageViewControllerDataSource

extension JobTemplate: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
 */

