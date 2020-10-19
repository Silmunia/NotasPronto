//
//  PlaceArchiveViewController.swift
//  NotasPronto
//
//  Created by Pedro Henrique Costa on 16/10/20.
//

import UIKit

class PlaceArchiveViewController: UIViewController {

	let mainView = BasicArchiveView()
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainView.archiveTable.delegate = self
		mainView.archiveTable.dataSource = self
		
		mainView.archiveTable.register(PlaceArchiveCell.self, forCellReuseIdentifier: "PlaceArchiveCell")
		
		self.view = mainView
		self.title = "item1"
	}
	
}

extension PlaceArchiveViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat(80)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = UIColor.clear
		return headerView
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceArchiveCell", for: indexPath) as? PlaceArchiveCell
		cell?.backgroundColor = .blue
		
		return cell!
	}
}
