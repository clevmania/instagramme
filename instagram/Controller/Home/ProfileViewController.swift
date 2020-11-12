//
//  ProfileViewController.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    private var collectionView : UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createSettingsNavigationButtonItem()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        layout.itemSize = CGSize(width: view.width / 3, height: view.width / 3)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
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

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
