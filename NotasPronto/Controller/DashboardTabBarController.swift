//
//  DashboardTabBarController.swift
//  NotasPronto
//
//  Created by Pedro Henrique Costa on 19/10/20.
//

import UIKit

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let item1 = HunterArchiveViewController()
		let icon1 = UITabBarItem(title: "Title", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
		item1.tabBarItem = icon1
		let controllers = [item1]  //array of the root view controllers displayed by the tab bar interface
		self.viewControllers = controllers
	}

	//Delegate methods
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		print("Should select viewController: \(viewController.title ?? "") ?")
		return true
	}
}
