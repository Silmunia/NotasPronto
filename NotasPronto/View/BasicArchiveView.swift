//
//  BasicArchiveView.swift
//  NotasPronto
//
//  Created by Pedro Henrique Costa on 19/10/20.
//

import UIKit

class BasicArchiveView: UIView {
	
	let archiveTable = BasicArchiveTable(frame: .zero, style: .plain)
	
	let segControl = UISegmentedControl(items: ["Hunters", "Workshop"])
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		
		setupArchiveTable()
		
		setupSegmentedControl()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupArchiveTable() {
		self.addSubview(archiveTable)
		
		archiveTable.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			archiveTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 75),
			archiveTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			archiveTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			archiveTable.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}
	
	func setupSegmentedControl() {
		self.addSubview(segControl)
		
		segControl.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			segControl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
			segControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
			segControl.widthAnchor.constraint(equalToConstant: 200),
			segControl.heightAnchor.constraint(equalToConstant: 40)
		])
		
		segControl.selectedSegmentIndex = 0
	}
}
