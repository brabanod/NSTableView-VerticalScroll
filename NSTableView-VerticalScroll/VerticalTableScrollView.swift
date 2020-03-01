//
//  VerticalTableScrollView.swift
//  tablevertical
//
//  Created by Pascal Braband on 01.03.20.
//  Copyright © 2020 Pascal Braband. All rights reserved.
//
//
//  Programmatic Implementation of vertical scrollable table view
//
//  NOTICE: NOT USED IN THE CURRENT APPLICATION

import Cocoa

class VerticalTableScrollView: NSScrollView {
    
    var tableView: NSTableView!
    var data: [Any]?
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup(columns: 1)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(columns: 1)
    }
    
    
    init(columns: Int, data: [Any]) {
        super.init(frame: .zero)
        self.data = data
        setup(columns: columns)
    }
    
    
    func setup(columns: Int) {
        self.documentView?.frame = self.frame
        
        tableView = NSTableView(frame: self.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewLeft = NSLayoutConstraint(item: tableView!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0)
        let tableViewRight = NSLayoutConstraint(item: tableView!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0)
        let tableViewTop = NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let tableViewBottom = NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        self.addSubview(tableView)
        self.addConstraints([tableViewLeft, tableViewRight, tableViewTop, tableViewBottom])
        
        // Setup columns
        for i in 0...columns {
            tableView.addTableColumn(NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column-\(i)")))
        }
        
        // TODO: Finish Implementation
    }
    
}
