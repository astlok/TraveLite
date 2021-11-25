//
//  ProfileScreenViewController.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import UIKit

final class ProfileScreenViewController: UIViewController {
	private let output: ProfileScreenViewOutput
    private let user: UserProfile?
    
    private let profileImageView  = UIImageView();
    private let background = UIImage(named: "back_profile")
    private let tableContainerViewController = UIViewController()
    private let label: UILabel = UILabel(frame: CGRect(x: 67, y: 240, width: 166.00, height: 30.00))

    init(output: ProfileScreenViewOutput, user: UserProfile?) {
        self.output = output
        self.user = user

        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        
        profileImageView.image = UIImage(named:"profile")
        profileImageView.layer.cornerRadius = 75
        profileImageView.clipsToBounds = true
        
        label.textAlignment = .center
        label.text = user?.nickname ?? "Маргарита Румынская"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 48)
        
        tableContainerViewController.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        
        let segmentTextContent = [
            NSLocalizedString("Прошел", comment: ""),
            NSLocalizedString("Загрузил", comment: "")
        ]
        
        let segmentedControl = UISegmentedControl(items: segmentTextContent)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.autoresizingMask = .flexibleWidth
        segmentedControl.addTarget(self, action: #selector(action(_:)), for: .valueChanged)
        
        self.view.addSubview(profileImageView)
        self.view.addSubview(label)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(tableContainerViewController.view)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 38).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 330).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
        
        tableContainerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        tableContainerViewController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableContainerViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableContainerViewController.view.heightAnchor.constraint(equalToConstant: 414).isActive = true
        tableContainerViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
    }
    
    func assignBackground() {
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    @IBAction func action(_ sender: UISegmentedControl) {
        let selected = sender.selectedSegmentIndex
        
        if let remove = tableContainerViewController.view.viewWithTag(1) {
            remove.removeFromSuperview()
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.tag = 1
        
        switch selected {
        case 0:
            label.text = "Прошел"
        case 1:
            label.text = "Загрузил"
        default:
            label.text = "FF"
        }
        
        tableContainerViewController.view.addSubview(label)
    }
    
}
    

extension ProfileScreenViewController: ProfileScreenViewInput {
}

