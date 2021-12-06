//
//  TabBarControllViewController.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 24/11/21.
//  
//

import UIKit

final class TabBarControllViewController: UITabBarController, UITabBarControllerDelegate {
	private let output: TabBarControllViewOutput
    
    init(output: TabBarControllViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .fullScreen
        
    }
    

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
	}
}

extension TabBarControllViewController: TabBarControllViewInput {
}
