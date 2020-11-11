//
//  SettingsViewController.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    private var data = [[SettingCellModel]]()

    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        let section = [SettingCellModel(title: "Log Out"){[weak self] in self?.logOutUser()}]
        data.append(section)
    }
    
    private func logOutUser(){
        DispatchQueue.main.async {
            let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "Log me out", style: .destructive){ _ in
                AuthManager.logOut { (isLogOutSuccessful) in
                    if isLogOutSuccessful {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated : true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else {
                        fatalError("Failed to log out user")
                    }
                }
            })
            
            actionSheet.popoverPresentationController?.sourceView = self.tableView
            actionSheet.popoverPresentationController?.sourceRect = self.tableView.bounds
            self.present(actionSheet, animated: true)
        }
    }

}

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}

struct SettingCellModel {
    var title : String
    var handler : () -> Void
}
