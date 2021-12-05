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
    
    let name: UILabel = UILabel(frame: CGRect(x: 67, y: -40, width: 166.00, height: 30.00))
    let difficult: InputView = InputView(frame: CGRect(x: 0, y: 2, width: 300.00, height: 30.00));
    let days: InputView = InputView(frame: CGRect(x: 0, y: 44, width: 300.00, height: 30.00));
    let things: InputView = InputView(frame: CGRect(x: 0, y: 86, width: 300.00, height: 30.00));
    let description1: InputView = InputView(frame: CGRect(x: 0, y: 128, width: 300.00, height: 30.00));
    let file: InputView = InputView(frame: CGRect(x: 0, y: 138, width: 300.00, height: 30.00));
    let submitButton: SubmitButtonView = SubmitButtonView(frame: CGRect(x: 0, y: 170, width: 300.00, height: 30.00));
    let importFilesButton: SubmitButtonView = SubmitButtonView(frame: CGRect(x: 0, y: 190, width: 300.00, height: 30.00));
    let writeFilesButton: SubmitButtonView = SubmitButtonView(frame: CGRect(x: 0, y: 220, width: 300.00, height: 30.00));
    let containerView = UIView()
    var bottomConstraint: NSLayoutConstraint?

    init(output: TravelScreenViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
        
        name.textAlignment = .center
        name.text = "Название"
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name.font = UIFont(name: "Montserrat-Regular", size: 24)

        difficult.placeholder = "Введите сложность"
        days.placeholder = "Введите количество дней"
        things.placeholder = "Введите вещи"
        description1.placeholder = "Введите описание"
        
        submitButton.setTitle("Создать аккаунт", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        submitButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)

        submitButton.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)
        
        importFilesButton.setTitle("Загрузить файл", for: .normal)
        importFilesButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        importFilesButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)

        importFilesButton.addTarget(self, action: #selector(importFiles), for: .touchUpInside)
        
        writeFilesButton.setTitle("Создать файл", for: .normal)
        writeFilesButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        writeFilesButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)

        writeFilesButton.addTarget(self, action: #selector(writeFiles), for: .touchUpInside)

        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);

        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(name)
        containerView.addSubview(difficult)
        containerView.addSubview(days)
        containerView.addSubview(things)
        containerView.addSubview(description1)
//        containerView.addSubview(submitButton)
        containerView.addSubview(importFilesButton)
        containerView.addSubview(writeFilesButton)
        
        view.addSubview(containerView)
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
	}
    
    @objc
    func tapSubmitButton() {
        //TODO: сделать валидацию
        var user: UserCreateRequest = UserCreateRequest.init(email: "", nickname: "", password: "")
        if let email = days.text {
            user.email = email
        } else {
            print("NOT VALID")
        }
        if let nickname = difficult.text {
            user.nickname = nickname
        } else {
            print("NOT VALID")
        }
        if let password = things.text {
            user.password = password
        } else {
            print("NOT VALID")
        }
        
//        output.didTapSubmitButton(with: user)
    }
    
    @objc
    func keyboardWillShow(sender: NSNotification) {
        bottomConstraint?.isActive = false

        bottomConstraint = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        bottomConstraint?.isActive = true

        self.view.layoutIfNeeded()
    }
    
    @objc
    func keyboardWillHide(sender: NSNotification) {
        bottomConstraint?.isActive = false

        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true

        self.view.layoutIfNeeded()
    }
    
    @IBAction func writeFiles(_ sender: Any) {
        
        let file = "\(UUID().uuidString).txt"
        let contents = "Some text..."
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    @IBAction func importFiles(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
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
        // https://stackoverflow.com/questions/28641325/using-uidocumentpickerviewcontroller-to-import-text-in-swift
        // надо как-то заставить работать
        file.text = String(contentsOfFile: selectedFileURL.path)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already exists! Do nothing")
        }
        else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                print("Copied file!")
            }
            catch {
                print("Error: \(error)")
            }
        }
    }
}

extension TravelScreenViewController: TravelScreenViewInput {
}
