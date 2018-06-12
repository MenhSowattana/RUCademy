//
//  BaseController.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForHideKeyboard()
    }
    
    fileprivate final func addGestureForHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToHideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapToHideKeyboard() {
        view.endEditing(true)
    }
    
}
