//
//  PopUp.swift
//  TraveLite
//
//  Created by Алексей Егоров on 28.11.2021.
//

import UIKit

class PopUp: UIView {
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
        return label
    }()
    
    fileprivate let submit: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 0.835, green: 0.835, blue: 0.788, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.setTitle("Изменить", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        btn.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        return btn
    }()
    
    fileprivate let cancel: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 0.583, green: 0.583, blue: 0.583, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.setTitle("Отменить", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        btn.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        return btn
    }()
    
    let nameInput: InputView = InputView()
    let passwordInput: InputView = InputView()
    let repeatPasswordInput: InputView = InputView()
    
    let container: UIViewController = UIViewController()
    var callback: (_ name: String, _ passwd: String) -> Any
    
    init(frame: CGRect, name: String, changeCallback: @escaping (_ name: String, _ passwd: String) -> Any) {
        callback = changeCallback
        
        super.init(frame: frame)
        
        nameInput.text = name
        
        self.backgroundColor = UIColor(red: 0.842, green: 0.842, blue: 0.842, alpha: 0.7)
        
        nameInput.placeholder = "Введите имя пользователя"
        passwordInput.placeholder = "Введите новый пароль"
        repeatPasswordInput.placeholder = "Повторите пароль"
        nameInput.layer.borderWidth = 1
        passwordInput.layer.borderWidth = 1
        repeatPasswordInput.layer.borderWidth = 1
        
        passwordInput.isSecureTextEntry = true
        repeatPasswordInput.isSecureTextEntry = true
        
        container.view.backgroundColor = .white
        container.view.layer.cornerRadius = 16
        
        container.view.addSubview(label)
        container.view.addSubview(nameInput)
        container.view.addSubview(passwordInput)
        container.view.addSubview(repeatPasswordInput)
        container.view.addSubview(submit)
        container.view.addSubview(cancel)
        self.addSubview(container.view)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: container.view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.topAnchor.constraint(equalTo: container.view.topAnchor, constant: 20).isActive = true
        
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        nameInput.centerXAnchor.constraint(equalTo: container.view.centerXAnchor).isActive = true
        nameInput.widthAnchor.constraint(equalToConstant: 240).isActive = true
        nameInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        nameInput.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.centerXAnchor.constraint(equalTo: container.view.centerXAnchor).isActive = true
        passwordInput.widthAnchor.constraint(equalToConstant: 240).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passwordInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 10).isActive = true
        
        repeatPasswordInput.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordInput.centerXAnchor.constraint(equalTo: container.view.centerXAnchor).isActive = true
        repeatPasswordInput.widthAnchor.constraint(equalToConstant: 240).isActive = true
        repeatPasswordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        repeatPasswordInput.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10).isActive = true
        
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.centerXAnchor.constraint(equalTo: container.view.centerXAnchor).isActive = true
        submit.widthAnchor.constraint(equalToConstant: 240).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 55).isActive = true
        submit.topAnchor.constraint(equalTo: repeatPasswordInput.bottomAnchor, constant: 20).isActive = true
        submit.addTarget(self, action: #selector(didTabSubmitButton), for: .touchUpInside)
        
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.centerXAnchor.constraint(equalTo: container.view.centerXAnchor).isActive = true
        cancel.widthAnchor.constraint(equalToConstant: 240).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        cancel.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 10).isActive = true
        cancel.addTarget(self, action: #selector(didTabCancelButton), for: .touchUpInside)
        
        container.view.translatesAutoresizingMaskIntoConstraints = false
        container.view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        container.view.heightAnchor.constraint(equalToConstant: 425).isActive = true
    }
    
    @objc
    func didTabCancelButton() {
        self.removeFromSuperview()
    }
    
    @objc func didTabSubmitButton() {
        var name: String = ""
        var password: String = ""
        
        if let text = nameInput.text {
            name = text
        } else {
            print("NOT VALID")
        }
        
        if let text = passwordInput.text {
            password = text
        } else {
            print("NOT VALID")
        }
        
        callback(name, password)
        
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
