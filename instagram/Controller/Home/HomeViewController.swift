//
//  ViewController.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleAuthState()
    }
    
    private func handleAuthState(){
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated : false)
        }
    }

}

