//
//  PhotoText.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-06.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit


class PhotoText: TaskTemplate {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = super.task.getPhoto()
         text.text = super.task.getText()
        self.navigationItem.title = "Photo Text"
     //   text.adjustsFontSizeToFitWidth = true
    }

}
