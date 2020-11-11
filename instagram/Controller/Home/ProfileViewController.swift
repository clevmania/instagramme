//
//  ProfileViewController.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createSettingsNavigationButtonItem()
    }
    
    private func createSettingsNavigationButtonItem(){
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(launchSettingsViewController))
    }
    
    @objc private func launchSettingsViewController(){
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
//        self.present(settingsVC, animated: true)
        navigationController?.pushViewController(settingsVC, animated: true)
    }

}
