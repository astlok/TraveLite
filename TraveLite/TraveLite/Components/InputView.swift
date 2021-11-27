//
//  InputView.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.11.2021.
//

import UIKit

class InputView: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0.8
        self.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.backgroundColor = .white
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5

        self.autocapitalizationType = .none
        self.font = UIFont(name: "Montserrat-Light", size: 16)
    }
    
    var textPadding = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
