//
//  BasicArchiveView.swift
//  NotasPronto
//
//  Created by Pedro Henrique Costa on 19/10/20.
//

import UIKit

class BasicArchiveView: UIView {

	let archiveTable = BasicArchiveTable(frame: .zero, style: .plain)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		
		self.addSubview(archiveTable)
		
		setupArchiveTable()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupArchiveTable() {
		archiveTable.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			archiveTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
			archiveTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			archiveTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			archiveTable.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}
}
