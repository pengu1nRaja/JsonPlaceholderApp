//
//  MainTVC.swift
//  JsonPlaceholderApp
//
//  Created by PenguinRaja on 09.10.2021.
//

import UIKit

class MainTVC: UITableViewController {
    
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let cellID: String = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        fetchUsers()
    }
    
    private func fetchUsers() {
        NetworkManager.shared.fetchUsersData { result in
        switch result {
            case .success(let users):
                self.users = users
            case .failure(_):
                print("Нет данных")
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let userDetailVC = UserDetailsVC()
        userDetailVC.title = users[indexPath.row].name
        userDetailVC.userId = users[indexPath.row].id
        
        navigationController?.pushViewController(userDetailVC, animated: true)
        
    }
}
