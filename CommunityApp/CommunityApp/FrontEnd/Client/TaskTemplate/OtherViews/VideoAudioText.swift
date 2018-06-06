//
//  VidAudTex.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class VidAudTex: UIViewController {
    
   // var analyticData: AnalyticData?
    
    override func viewDidLoad() {
    //    self.analyticData = AnalyticData()
    }

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

override func viewWillDisappear(_ animated: Bool) {
    saveAnalytics()
    
}

private func saveAnalytics() {
//    if let analytics = self.analyticData {
//        // Save analytics to Core Data
//    } else {
//        print("There is no analytics to save")
//    }
//    
}

}
