//
//  TreksScreenViewController.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 3/12/21.
//  
//

import UIKit

final class TreksScreenViewController: UIViewController {
    private let tableView = UITableView()
    
	private let output: TreksScreenViewOutput

    init(output: TreksScreenViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem = UITabBarItem(title: "", image: UIImage(named: "maps"), selectedImage: UIImage(named: "maps"))
        
        view.backgroundColor = .white

    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
//        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TreksScreenViewCell.self, forCellReuseIdentifier: "TreksScreenViewCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        
        tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
	}
    
    override func viewDidAppear(_ animated: Bool) {
        output.didLoadView()
    }
    
    @objc
    private func didPullToRefresh() {
        output.didPullToRefresh()
    }
}

extension TreksScreenViewController: UITableViewDelegate, UITableViewDataSource {
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

extension TreksScreenViewController: TreksScreenViewInput {
    func reloadData() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
}
