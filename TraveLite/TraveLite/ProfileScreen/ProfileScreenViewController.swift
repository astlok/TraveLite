//
//  ProfileScreenViewController.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import UIKit

final class ProfileScreenViewController: UIViewController {
//    var userData: UserProfile?
	private let output: ProfileScreenViewOutput
    private let user: UserProfile?
    private let profileImageView  = UIImageView();
    private let background = UIImage(named: "profile_background")
    let containerView = UIView()
    var bottomConstraint: NSLayoutConstraint?
    let label: UILabel = UILabel(frame: CGRect(x: 67, y: 240, width: 166.00, height: 30.00))
    let raiting: UILabel = UILabel(frame: CGRect(x: 70, y: 270, width: 166.00, height: 30.00))

    init(output: ProfileScreenViewOutput, user: UserProfile?) {
        self.output = output
        self.user = user


        super.init(nibName: nil, bundle: nil)
        profileImageView.image = UIImage(named:"bars")
        profileImageView.layer.cornerRadius = 75
        profileImageView.clipsToBounds = true
        
        label.textAlignment = .center
        label.text = user?.nickname
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 48)
        
        raiting.textAlignment = .center
        raiting.text = "Рейтинг 0.0"
        raiting.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        raiting.font = UIFont(name: "Montserrat-Regular", size: 12)
        
        tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        assignBackground()
        

        
        self.view.addSubview(profileImageView)
        view.addSubview(containerView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
//        profileImageView.addSubview(label)
        containerView.addSubview(label)
        containerView.addSubview(raiting)
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
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
    
}
    

extension ProfileScreenViewController: ProfileScreenViewInput {
}

