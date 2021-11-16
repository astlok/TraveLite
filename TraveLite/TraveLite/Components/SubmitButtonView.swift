//
//  SubmitButtonView.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.11.2021.
//

import UIKit

class SubmitButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.71, green: 0.72, blue: 0.63, alpha: 0.5)
        self.layer.cornerRadius = 10
        self.setTitle("Войти", for: .normal)
        self.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 18)
        self.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        self.addTarget(self, action: #selector(self.inTapAnimation(sender:)), for: .touchDown)
        self.addTarget(self, action:  #selector(self.outTapAnimation(sender:)), for: .touchUpInside)
    }
    
    @objc fileprivate func inTapAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            sender.backgroundColor = UIColor(red: 0.71, green: 0.72, blue: 0.63, alpha: 1)
        })
    }
    
    @objc fileprivate func outTapAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            sender.backgroundColor = UIColor(red: 0.71, green: 0.72, blue: 0.63, alpha: 0.5)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
