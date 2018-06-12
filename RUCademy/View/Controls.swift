//
//  Controls.swift
//  RUCademy
//
//  Created by Sowattana on 6/5/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

@IBDesignable
class MyButton: UIButton {
    
    var indicatorView: NVActivityIndicatorView!
    var isLoading = false
    var myTitle = ""
    var myIcon: UIImage?
    
    @IBInspectable
    var borderColor: UIColor = .lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    
    func setLoading(loading: Bool) {
        if loading {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    fileprivate final func startLoading() {
        if indicatorView == nil {
            let indicatorHeight: CGFloat = 30
            let indicatorWidth: CGFloat = 30
            let loadingFrame = CGRect(x: (frame.width - indicatorWidth) / 2, y: (frame.height - indicatorHeight) / 2, width: indicatorWidth, height: indicatorHeight )
            let type = NVActivityIndicatorType.circleStrokeSpin
            indicatorView = NVActivityIndicatorView(frame: loadingFrame , type: type, color: UIColor.white, padding: 5)
            addSubview(indicatorView)
        }
        myTitle = title(for: .normal) ?? ""
        myIcon = image(for: .normal)
        setTitle("", for: .normal)
        setImage(nil, for: .normal)
        indicatorView.startAnimating()
        isLoading = true
    }
    
    fileprivate final func stopLoading() {
        if isLoading {
            setTitle(myTitle, for: .normal)
            setImage(myIcon, for: .normal)
            indicatorView.stopAnimating()
            indicatorView = nil
            isLoading = false
        }
    }
    
}




@IBDesignable
class MyUITextField: UITextField {
    
    @IBInspectable
    var borderColor: UIColor = .lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.leftView == nil {
            let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
            addSubview(leftPadding)
            leftView = leftPadding
            leftViewMode = .always
        }
    }
    
}

@IBDesignable
class MyUITextView: UITextView {
    
    @IBInspectable
    var borderColor: UIColor = .lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    
}
