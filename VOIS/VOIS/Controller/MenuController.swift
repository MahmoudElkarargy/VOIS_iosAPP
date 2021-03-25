//
//  MenuController.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit
private let reusedIdentifer = "MenuOption"

class MenuController: UIViewController{
    // MARK: - Properties
    var tableView: UITableView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    // MARK: - Handlers
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reusedIdentifer)
        tableView.backgroundColor = UIColor(hex: "#102976ff")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedIdentifer, for: indexPath) as! MenuOptionCell
        return cell
    }
    
    
}
