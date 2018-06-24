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
    
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = super.task.getText()
    }
}
