//
//  ViewController.swift
//  tablevertical
//
//  Created by Pascal Braband on 01.03.20.
//  Copyright © 2020 Pascal Braband. All rights reserved.
//
//  Steps:
//  1. ScrollView constraints dont matter
//  2. TableView constraints all to 0
//  3. Each CellView needs to have leading and trailing constraint!
//  4. set documentView.frame
//  5. Resize columns
//
//  Resizing Columns:
//  https://stackoverflow.com/a/49463812/3272409



import Cocoa

class ViewController: NSViewController {
    
    let data = [["lorem ipsum", "dolor sit", "amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt"],
                ["aliquyam erat", "sed diam", "voluptua At vero eos et accusam et justo duo dolores et ea rebum"],
                ["Stet clita", "kasd gubergren", "no sea takimata sanctus est Lorem ipsum dolor sit amet"],
                ["lorem ipsum", "dolor sit", "amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt"],
                ["aliquyam erat", "sed diam", "voluptua At vero eos et accusam et justo duo dolores et ea rebum"],
                ["Stet clita", "kasd gubergren", "no sea takimata sanctus est Lorem ipsum dolor sit amet"],
                ["lorem ipsum", "dolor sit", "amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt"],
                ["aliquyam erat", "sed diam", "voluptua At vero eos et accusam et justo duo dolores et ea rebum"],
                ["Stet clita", "kasd gubergren", "no sea takimata sanctus est Lorem ipsum dolor sit amet"],
                ["lorem ipsum", "dolor sit", "amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt"],
                ["aliquyam erat", "sed diam", "voluptua At vero eos et accusam et justo duo dolores et ea rebum"],
                ["Stet clita", "kasd gubergren", "no sea takimata sanctus est Lorem ipsum dolor sit amet"]]
    
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var scrollView: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove padding in scrollView's documentView
        scrollView.documentView?.frame = scrollView.frame
        
        // Resize all columns to fit their content
        self.autoSizeTableColumns()
    }
}




extension ViewController: NSTableViewDelegate {
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: tableColumn?.identifier ?? .init(rawValue: "cellId-\(row)"), owner: self) as? NSTableCellView
        let item = data[row]
        
        // Get text for cell and assign to textfield
        var text = ""
        if tableColumn == tableView.tableColumns[0] {
            text = getDataFor(item: item, column: 0)
        } else if tableColumn == tableView.tableColumns[1] {
            text = getDataFor(item: item, column: 1)
        } else if tableColumn == tableView.tableColumns[2] {
            text = getDataFor(item: item, column: 2)
        }
        cell?.textField?.stringValue = text
        cell?.textField?.font = NSFont.monospacedSystemFont(ofSize: 12.0, weight: .regular)
        
        return cell
    }
    
    
    /** Applies `sizeToFit` for all columns. */
    func autoSizeTableColumns() {
        for column in 0...tableView.tableColumns.count-1 {
            sizeToFit(column: column, padding: 10.0)
        }
        tableView.reloadData()
    }
    

    /** Calculates the `minWidth` for the given column (index), using the whole data array and testing out the minimum width needed. */
    func sizeToFit(column: Int, padding: CGFloat) {
        if let view = tableView.view(atColumn: column, row: 0, makeIfNecessary: true) as? NSTableCellView {
            var width = self.tableView.tableColumns[column].minWidth
            for item in data {
                view.textField?.stringValue = getDataFor(item: item, column: column)
                let size = view.fittingSize
                width = max(width, size.width + padding)
            }
            self.tableView.tableColumns[column].minWidth = width
        }
    }
    
    
    /** Returns data for a given item and column. Maybe something more complicated than array access. For example when `item` is a struct. */
    func getDataFor(item: Any, column: Int) -> String {
        return (item as? [String])?[column] ?? ""
    }
    
    
}




extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
}
