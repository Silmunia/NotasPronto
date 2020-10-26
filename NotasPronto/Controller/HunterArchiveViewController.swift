//
//  HunterArchiveViewController.swift
//  NotasPronto
//
//  Created by Pedro Henrique Costa on 16/10/20.
//

import UIKit

class HunterArchiveViewController: UIViewController {

	let mainView = BasicArchiveView()
	
	let context = AppDelegate.viewContext
	
	var hunterArchive: [Hunter]?
	var workshopArchive: [Workshop]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainView.archiveTable.delegate = self
		mainView.archiveTable.dataSource = self
		
		mainView.archiveTable.register(ArchiveCell.self, forCellReuseIdentifier: "ArchiveCell")
		
		mainView.segControl.addTarget(self, action: #selector(self.pressedControl), for: .valueChanged)
		
		self.view = mainView
		
		setupNavBar()
		
		fetchArchiveData(from: "Hunters")
	}
	
	func setupNavBar() {
		self.navigationItem.title = "Hunter Archive"
		self.navigationController?.overrideUserInterfaceStyle = .light
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addEntry))
	}
	
	@objc func pressedControl() {
		
		if mainView.segControl.selectedSegmentIndex == 0 {
			
			self.navigationItem.title = "Hunter Archive"
			fetchArchiveData(from: "Hunters")
		} else {
			
			self.navigationItem.title = "Workshop Archive"
			fetchArchiveData(from: "Workshops")
		}
	}
	
	@objc func addEntry() {
		
		if mainView.segControl.selectedSegmentIndex == 0 {
			
			let newHunter = Hunter(context: self.context)
			newHunter.name = "Djura"
			
			do {
				try self.context.save()
			} catch {
				print(error)
			}
			
			self.fetchArchiveData(from: "Hunters")
		} else {
			
			let newWorkshop = Workshop(context: self.context)
			newWorkshop.name = "Powder Keg"
			
			do {
				try self.context.save()
			} catch {
				print(error)
			}
			
			self.fetchArchiveData(from: "Workshops")
		}
	}
	
	func fetchArchiveData(from type: String) {
		
		if type == "Hunters" {
			
			do {
				self.hunterArchive = try context.fetch(Hunter.fetchRequest())
			} catch {
				print(error)
			}
		} else if type == "Workshops" {
			
			do {
				self.workshopArchive = try context.fetch(Workshop.fetchRequest())
			} catch {
				print(error)
			}
		} else {
			//alert
		}
		
		DispatchQueue.main.async {
			self.mainView.archiveTable.reloadData()
		}
	}
}

extension HunterArchiveViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if mainView.segControl.selectedSegmentIndex == 0 {
			
			let selectedHunter = self.hunterArchive![indexPath.row]
			
			let alert = UIAlertController(title: "Edit Hunter", message: "Change the Hunter's name", preferredStyle: .alert)
			alert.addTextField()
			
			let alertText = alert.textFields![0]
			alertText.text = selectedHunter.name
			
			let saveButton = UIAlertAction(title: "Save name", style: .default) { (action) in
				
				let textField = alert.textFields![0]
				
				selectedHunter.name = textField.text
				
				do {
					try self.context.save()
				} catch {
					print(error)
				}
				
				self.fetchArchiveData(from: "Hunters")
			}
			
			alert.addAction(saveButton)
			self.present(alert, animated: true, completion: nil)
		} else {
			
			let selectedWorkshop = self.workshopArchive![indexPath.row]
			
			let alert = UIAlertController(title: "Edit Workshop", message: "Change the Workshop's name", preferredStyle: .alert)
			alert.addTextField()
			
			let alertText = alert.textFields![0]
			alertText.text = selectedWorkshop.name
			
			let saveButton = UIAlertAction(title: "Save name", style: .default) { (action) in
				
				let textField = alert.textFields![0]
				
				selectedWorkshop.name = textField.text
				
				do {
					try self.context.save()
				} catch {
					print(error)
				}
				
				self.fetchArchiveData(from: "Workshops")
			}
			
			alert.addAction(saveButton)
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if mainView.segControl.selectedSegmentIndex == 0 {
			return hunterArchive?.count ?? 0
		} else {
			return workshopArchive?.count ?? 0
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat(0)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = UIColor.clear
		return headerView
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath) as? ArchiveCell
		cell?.backgroundColor = .yellow
		
		if mainView.segControl.selectedSegmentIndex == 0 {
			let hunter = self.hunterArchive![indexPath.row]
			cell?.textLabel?.text = hunter.name
		} else {
			let workshop = self.workshopArchive![indexPath.row]
			cell?.textLabel?.text = workshop.name
		}
		
		return cell!
	}
	
	func  tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
			
			if self.mainView.segControl.selectedSegmentIndex == 0 {
				let hunterToRemove = self.hunterArchive![indexPath.row]
				
				self.context.delete(hunterToRemove)
				do {
					try self.context.save()
				} catch {
					print(error)
				}
				
				self.fetchArchiveData(from: "Hunters")
			} else {
				let workshopToRemove = self.workshopArchive![indexPath.row]
				
				self.context.delete(workshopToRemove)
				do {
					try self.context.save()
				} catch {
					print(error)
				}
				
				self.fetchArchiveData(from: "Workshops")
			}
		}
		
		return UISwipeActionsConfiguration(actions: [action])
	}
}
