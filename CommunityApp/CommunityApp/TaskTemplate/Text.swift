//
//  Tex.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class Text: TaskTemplate {
    

    @IBOutlet weak var text: UILabel!
    var textLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = super.getText(self.textLocation)
    }
    
    func setTextData(textLocation: String) {
        self.textLocation = textLocation
    }
    
    
}
