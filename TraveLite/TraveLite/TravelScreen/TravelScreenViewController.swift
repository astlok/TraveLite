//
//  TravelScreenViewController.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 26.11.2021.
//  
//

import UIKit
import MobileCoreServices

final class TravelScreenViewController: UIViewController, UIDocumentPickerDelegate {
    private let output: TravelScreenViewOutput
    private var trek: TrekCreateRequest = TrekCreateRequest(name: "", difficult: 0, days: 0, description: "", file: "", region: "")
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let nameInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите название маршрута"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(checkNameInput), for: .editingChanged)
        input.addTarget(self, action: #selector(checkNameInput), for: .editingDidBegin)

        return input
    }()
    
    let nameInputSuggest: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Имя должно быть длиннее 4 символов"
        label.isHidden = true
        
        return label
    }()
    
    let difficultInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите сложность"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(checkDifficultInput), for: .editingChanged)
        input.addTarget(self, action: #selector(checkDifficultInput), for: .editingDidBegin)

        return input
    }()
    
    let difficultInputSuggest: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Сложность должна быть числом от 0 до 5"
        label.isHidden = true
        
        return label
    }()
    
    let daysInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите кол-во дней похода"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(checkDaysInput), for: .editingChanged)
        input.addTarget(self, action: #selector(checkDaysInput), for: .editingDidBegin)

        return input
    }()
    
    let daysInputSuggest: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Дни должны быть числом от 0 до 365"
        label.isHidden = true
        
        return label
    }()
    
    let descriptionInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите описание похода"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(checkDescriptionInput), for: .editingChanged)
        input.addTarget(self, action: #selector(checkDescriptionInput), for: .editingDidBegin)

        return input
    }()
    
    let descriptionInputSuggest: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Длина описания должна минимум 20 символов"
        label.isHidden = true
        
        return label
    }()
    
    let regionInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите регион маршрута"
        input.translatesAutoresizingMaskIntoConstraints = false

        return input
    }()
    
    let fileButton: SubmitButtonView = {
        let button = SubmitButtonView()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.backgroundColor = .systemGray5
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        button.addTarget(self, action: #selector(importFiles), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let fileButtonSuggest: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Необходимо загрузить файл"
        label.isHidden = true
        
        return label
    }()


    
    let submitButton: SubmitButtonView = {
        let button = SubmitButtonView()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        button.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    let contentView = UIView()
    let scrollView = UIScrollView()
    var bottomConstraint: NSLayoutConstraint?
    var topLabelConstraint: NSLayoutConstraint?
    
    init(output: TravelScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
        let tabImageProfile = UIImage(named: "plus")
                tabBarItem = UITabBarItem(title: "", image: tabImageProfile, selectedImage: tabImageProfile)
        
        view.backgroundColor = .white
        modalPresentationStyle = .fullScreen
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        setupScrollView()
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc
    func tapSubmitButton() {
        checkFileButton()
        
        let isOkValidate = nameInputSuggest.isHidden && difficultInputSuggest.isHidden && daysInputSuggest.isHidden && fileButtonSuggest.isHidden && descriptionInputSuggest.isHidden
        
        if !isOkValidate {
            return
        }
        
        if let name = nameInput.text {
            trek.name = name
        } else {
            print("NOT VALID")
        }
        if let difficult = difficultInput.text {
            trek.difficult = Int(difficult) ?? 1
        } else {
            print("NOT VALID")
        }
        if let days = daysInput.text {
            trek.days = Int(days) ?? 1
        } else {
            print("NOT VALID")
        }
        if let descr = descriptionInput.text {
            trek.description = descr
        } else {
            print("NOT VALID")
        }
        if let region = regionInput.text {
            trek.region = region
        } else {
            print("NOT VALID")
        }
        
        difficultInput.text = ""
        daysInput.text = ""
        descriptionInput.text = ""
        regionInput.text = ""
        nameInput.text = ""

        output.didSubmit(trek: trek)
    }

    @objc
    func keyboardWillShow(sender: NSNotification) {
        bottomConstraint?.isActive = false
        
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardHeight)
            bottomConstraint?.isActive = true
            
            self.view.layoutIfNeeded()
        }
    }

    @objc
    func keyboardWillHide(sender: NSNotification) {
        bottomConstraint?.isActive = false
        
        bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true

        self.view.layoutIfNeeded()
    }
    
    func setupScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    //        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

            bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            bottomConstraint?.isActive = true
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    //        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        }
    
    func setup() {
        contentView.subviews.forEach({ $0.removeFromSuperview()})
        
        textLabel.text = "Создание маршрута"
        contentView.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        topLabelConstraint?.isActive = false
        topLabelConstraint = textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.bounds.height / 2 - 350)
        topLabelConstraint?.isActive = true
        
        textLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(nameInput)
        nameInput.text = ""
        nameInput.layer.borderColor = UIColor.gray.cgColor
        nameInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameInput.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
        nameInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        nameInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(nameInputSuggest)
        nameInputSuggest.isHidden = true
        nameInputSuggest.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameInputSuggest.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 2).isActive = true
        nameInputSuggest.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(difficultInput)
        difficultInput.text = ""
        difficultInput.layer.borderColor = UIColor.gray.cgColor
        difficultInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        difficultInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 20).isActive = true
        difficultInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        difficultInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(difficultInputSuggest)
        difficultInputSuggest.isHidden = true
        difficultInputSuggest.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        difficultInputSuggest.topAnchor.constraint(equalTo: difficultInput.bottomAnchor, constant: 2).isActive = true
        difficultInputSuggest.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(daysInput)
        daysInput.text = ""
        daysInput.layer.borderColor = UIColor.gray.cgColor
        daysInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        daysInput.topAnchor.constraint(equalTo: difficultInput.bottomAnchor, constant: 20).isActive = true
        daysInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        daysInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(daysInputSuggest)
        daysInputSuggest.isHidden = true
        daysInputSuggest.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        daysInputSuggest.topAnchor.constraint(equalTo: daysInput.bottomAnchor, constant: 2).isActive = true
        daysInputSuggest.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(descriptionInput)
        descriptionInput.text = ""
        descriptionInput.layer.borderColor = UIColor.gray.cgColor
        descriptionInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionInput.topAnchor.constraint(equalTo: daysInput.bottomAnchor, constant: 20).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        descriptionInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(descriptionInputSuggest)
        descriptionInputSuggest.isHidden = true
        descriptionInputSuggest.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionInputSuggest.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: 2).isActive = true
        descriptionInputSuggest.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(regionInput)
        regionInput.text = ""
        regionInput.layer.borderColor = UIColor.gray.cgColor
        regionInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        regionInput.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: 20).isActive = true
        regionInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        regionInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(fileButton)
        fileButton.setTitle("Загрузить файл", for: .normal)
        fileButton.layer.borderColor = UIColor.gray.cgColor
        fileButton.backgroundColor = .systemGray5
        fileButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        fileButton.topAnchor.constraint(equalTo: regionInput.bottomAnchor, constant: 20).isActive = true
        fileButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        fileButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(fileButtonSuggest)
        fileButtonSuggest.isHidden = true
        fileButtonSuggest.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        fileButtonSuggest.topAnchor.constraint(equalTo: fileButton.bottomAnchor, constant: 2).isActive = true
        fileButtonSuggest.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(submitButton)
        submitButton.setTitle("Создать маршрут", for: .normal)
        submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: fileButton.bottomAnchor, constant: 20).isActive = true
        submitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    @objc
    func importFiles(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
        
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)

        var text2 = ""
        do {
            //TODO: Если юзаешь симулятор - замени selectedFileURL на sandboxFileURL
            text2 = try String(contentsOf: selectedFileURL, encoding: .utf8)
        }
        catch  {
            print("Error \(error)")
        }
        
        trek.file = text2
    }
    
    @objc
    func checkNameInput(_ sender: UITextField) {
        if sender.text?.count ?? 0 < 4 {
            sender.layer.borderColor = UIColor.red.cgColor
            nameInputSuggest.isHidden = false
        } else {
            sender.layer.borderColor = UIColor.green.cgColor
            nameInputSuggest.isHidden = true
        }
    }
    
    @objc
    func checkDifficultInput(_ sender: UITextField) {
        let data = Int(sender.text ?? "") ?? -1
            
        if data > 0 && data <= 5 {
            sender.layer.borderColor = UIColor.green.cgColor
            difficultInputSuggest.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            difficultInputSuggest.isHidden = false
        }
    }
    
    @objc
    func checkDaysInput(_ sender: UITextField) {
        let data = Int(sender.text ?? "") ?? -1
            
        if data > 0 && data <= 365 {
            sender.layer.borderColor = UIColor.green.cgColor
            daysInputSuggest.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            daysInputSuggest.isHidden = false
        }
    }
    
    @objc
    func checkDescriptionInput(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 20 {
            sender.layer.borderColor = UIColor.green.cgColor
            descriptionInputSuggest.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            descriptionInputSuggest.isHidden = false
        }
    }
    
    @objc
    func checkFileButton() {
        if trek.file != "" {
            fileButtonSuggest.isHidden = true
        } else {
            fileButtonSuggest.isHidden = false
        }
    }
}

extension TravelScreenViewController: TravelScreenViewInput {
}

