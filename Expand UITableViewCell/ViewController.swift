//
//  ViewController.swift
//  Expand UITableViewCell
//
//  Created by Kha on 4/21/20.
//  Copyright © 2020 Kha. All rights reserved.
//

import UIKit

public struct Item {
    var name: String
    var detail: String
    
    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        Section(name: "Section 1", items: [
            Item(name: "Item 1", detail: ""),
            Item(name: "Item 2", detail: ""),
            Item(name: "Item 3", detail: ""),
            Item(name: "Item 4", detail: ""),
            Item(name: "Item 5", detail: ""),
            Item(name: "Item 6", detail: ""),
        ]),
        Section(name: "Section 2", items: [
            Item(name: "Item 1", detail: ""),
            Item(name: "Item 2", detail: ""),
            Item(name: "Item 3", detail: ""),
            Item(name: "Item 4", detail: ""),
            Item(name: "Item 5", detail: ""),
            Item(name: "Item 6", detail: ""),
            Item(name: "Item 7", detail: ""),
        ]),
        Section(name: "Section 3", items: [
            Item(name: "Item 1", detail: ""),
            Item(name: "Item 2", detail: ""),
            Item(name: "Item 3", detail: ""),
            Item(name: "Item 4", detail: ""),
            Item(name: "Item 5", detail: ""),
            Item(name: "Item 6", detail: ""),
            Item(name: "Item 7", detail: ""),
        ]),
        Section(name: "Section 4", items: [
            Item(name: "Item 1", detail: ""),
            Item(name: "Item 2", detail: ""),
            Item(name: "Item 3", detail: ""),
            Item(name: "Item 4", detail: ""),
            Item(name: "Item 5", detail: ""),
            Item(name: "Item 6", detail: ""),
            Item(name: "Item 7", detail: ""),
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Số Section trong TableVIew
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //Số row trong mỗi Section:
    //0: sections[section].collapsed == true
    //sections[section].items.count: sections[section].items.count == false
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed
            ? 0 : sections[section].items.count
    }
    
    //Header trong TableView
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
        header.backgroundColor = .lightGray
        header.titleLabel.text = sections[section].name
        header.section = section
        header.delegate = self
        return header
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].name
        return cell
    }
}

//Mỗi khi tap vào Header sẽ reload section
//dựa vào sections[section].collapsed và vị trí section
extension ViewController: HeaderViewDelegate {
    func toggleSection(_ header: HeaderView, section: Int) {
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
