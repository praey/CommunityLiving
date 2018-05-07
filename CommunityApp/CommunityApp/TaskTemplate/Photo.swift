//
//  Pho.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class Photo: TaskTemplate {
    // When it comes to this it has to set the 1. Photo
    
    @IBOutlet weak var image: UIImageView!
    var photoLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = super.getPhoto(self.photoLocation)
    }
    
    func setPhotoData(photoLocation: String) {
        self.photoLocation = photoLocation
    }

}
