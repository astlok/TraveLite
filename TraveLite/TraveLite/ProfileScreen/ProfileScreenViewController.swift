//
//  ProfileScreenViewController.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import UIKit
import Kingfisher

final class ProfileScreenViewController: UIViewController {
	private let output: ProfileScreenViewOutput
    private var user: UserProfile?
    
    private let profileImageView  = UIImageView();
    private let background = UIImage(named: "back_profile")
    private let tableContainerViewController = UIViewController()
    private let label: UILabel = UILabel()
    private let settings = UIImageView(image: UIImage(named: "settings_icon"))

    private let exit = UIImageView(image: UIImage(named: "exit"))
    
    private let tableView = UITableView()
    
    let notFoundLabel = UILabel()

    init(output: ProfileScreenViewOutput, user: UserProfile?) {
        self.output = output
        self.user = user


        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        
        profileImageView.image = UIImage(named:"profile")

        profileImageView.layer.cornerRadius = 75
        profileImageView.clipsToBounds = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tabOnImage))
        profileImageView.addGestureRecognizer(tapGR)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.contentMode = .scaleToFill
        
        label.textAlignment = .center
        label.text = user?.nickname ?? "Имя Фамилия"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSettingsButton))
        settings.isUserInteractionEnabled = true
        settings.addGestureRecognizer(singleTap)
        
        let exitTap = UITapGestureRecognizer(target: self, action: #selector(tapExitButton))
        exit.isUserInteractionEnabled = true
        exit.addGestureRecognizer(exitTap)
        
        tableContainerViewController.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let tabImageProfile = UIImage(named: "profile_icon")
        tabBarItem = UITabBarItem(title: "", image: tabImageProfile, selectedImage: tabImageProfile)
        
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
//        assignBackground()
        
        let segmentTextContent = [
//            NSLocalizedString("Пройдено", comment: ""),
            NSLocalizedString("Ваши маршруты", comment: "")
        ]
        
        let segmentedControl = UISegmentedControl(items: segmentTextContent)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.autoresizingMask = .flexibleWidth
        
        self.view.addSubview(profileImageView)
        self.view.addSubview(label)
        self.view.addSubview(settings)
        self.view.addSubview(exit)
        self.view.addSubview(tableContainerViewController.view)
        self.view.addSubview(segmentedControl)
        
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -22).isActive = true
        settings.widthAnchor.constraint(equalToConstant: 25).isActive = true
        settings.heightAnchor.constraint(equalToConstant: 25).isActive = true
        settings.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        
        exit.translatesAutoresizingMaskIntoConstraints = false
        exit.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 22).isActive = true
        exit.widthAnchor.constraint(equalToConstant: 25).isActive = true
        exit.heightAnchor.constraint(equalToConstant: 25).isActive = true
        exit.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 330).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60).isActive = true
        
        tableContainerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        tableContainerViewController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableContainerViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
//        tableContainerViewController.view.heightAnchor.constraint(equalToConstant: 370).isActive = true
        tableContainerViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        tableContainerViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        notFoundLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        notFoundLabel.font = UIFont(name: "Montserrat-Light", size: 24)
        notFoundLabel.numberOfLines = 0
        notFoundLabel.lineBreakMode = .byWordWrapping
        notFoundLabel.textAlignment = .center
        notFoundLabel.text = "Вы еще добавляли маршруты"
        
        tableContainerViewController.view.addSubview(notFoundLabel)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TreksScreenViewCell.self, forCellReuseIdentifier: "TreksScreenViewCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableContainerViewController.view.addSubview(tableView)
        
        tableView.centerXAnchor.constraint(equalTo: tableContainerViewController.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: tableContainerViewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableContainerViewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: tableContainerViewController.view.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        output.didLoadView()
    }
    
    func assignBackground() {
        var imageView = UIImageView()
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc
    func tabOnImage(_ sender: UITapGestureRecognizer) {
        if sender.state != .ended {
            return
        }
        
        showImagePickerControllerActionSheet()
    }
}
    
extension ProfileScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Выбрать из галлереи", style: .default) { (action) in
                    self.showImagePickerController(sourceType: .photoLibrary)
            }
        let cameraAction = UIAlertAction(title: "Сделать фотографию", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
            }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                
        AlertService.showAlert(style: .actionSheet, title: "Выбор изображения", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            output.didSelectedProfileImage(image: editedImage, id: user?.id ?? 0)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func tapSettingsButton(sender: UIImageView) {
        let popup = PopUp(frame: CGRect(), name: user?.nickname ?? "Имя Фамилия", changeCallback: change)
        self.view.addSubview(popup)
        
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popup.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        popup.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        popup.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        popup.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    @objc
    func tapExitButton(sender: UIImageView) {
        output.didExit()
    }
    
    func change(_ name: String, _ passwd: String) {
        let changes = UserCreateRequest(email: user?.email ?? "", nickname: name, password: passwd)
        output.didChange(user: changes)
    }
    
    @objc
    internal func didPullToRefresh() {
        output.didPullToRefresh()
    }
}


extension ProfileScreenViewController: ProfileScreenViewInput {
    func displayChangesProfile(user: UserCreateRequest) {
        self.user?.nickname = user.nickname
        label.text = user.nickname
    }
    
    func displayImage(image: String) {
        let url = URL(string: image)
        profileImageView.kf.setImage(with: url)
    }
    
    func reloadData() {
        if output.itemsCount != 0 {
            notFoundLabel.removeFromSuperview()
        } else {
            tableContainerViewController.view.addSubview(notFoundLabel)
            
            notFoundLabel.translatesAutoresizingMaskIntoConstraints = false
            notFoundLabel.centerXAnchor.constraint(equalTo: tableContainerViewController.view.centerXAnchor).isActive = true
            notFoundLabel.centerYAnchor.constraint(equalTo: tableContainerViewController.view.centerYAnchor).isActive = true
            notFoundLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}


extension ProfileScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreksScreenViewCell") as? TreksScreenViewCell
        
        cell?.configure(with: output.item(at: indexPath.row))
        
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.itemsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath.row)
    }
    
}

