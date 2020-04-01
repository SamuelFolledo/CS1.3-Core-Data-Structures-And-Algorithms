//
//  UnderlinedTextField.swift
//  FolledoUserAuth
//
//  Created by Macbook Pro 15 on 11/14/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//
//  inspired by Stackoverflow's post https://stackoverflow.com/questions/31107994/how-to-only-show-bottom-border-of-uitextfield-in-swift/31108018

import UIKit

///UITextField as just line with no borders. Can change the line color
class UnderlinedTextField: UITextField {
//views
    private let defaultUnderlineColor = UIColor.black
    private let bottomLine = UIView()
    
//setup
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init() { //with initializer
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        borderStyle = .none
        contentVerticalAlignment = .center //added
        clearButtonMode = .unlessEditing //added
        tintColor = defaultUnderlineColor
        font = UIFont.boldSystemFont(ofSize: 18) //added
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = defaultUnderlineColor
        self.addSubview(bottomLine)
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true //updated to make the line closer to the text
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    }

//Setters
    public func setUnderlineColor(color: UIColor = .red) {
        bottomLine.backgroundColor = color
    }

    public func setDefaultUnderlineColor() {
        bottomLine.backgroundColor = defaultUnderlineColor
    }
    
//Helpers
    public func hasError() {
            self.setUnderlineColor(color: .systemRed)
        }
    
    public func hasNoError() {
        self.setDefaultUnderlineColor()
    }
}
