//
//  HomeViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 24/04/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sports = [SportCategory(name: "", image: "")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if OnBoardingManager.shared.isNewuser(){
            let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            welcomeVC.modalPresentationStyle = .fullScreen
            present(welcomeVC, animated: true)
        }
    }


}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
}
