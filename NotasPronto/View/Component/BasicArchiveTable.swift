//
//  BasicArchiveTable.swift
//  NotasPronto
//
//  Created by Pedro Henrique Costa on 19/10/20.
//

import UIKit

class BasicArchiveTable: UITableView {

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		self.backgroundColor = .black
		self.alwaysBounceHorizontal = false
		self.tableFooterView = UIView()
		self.rowHeight = 40
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
