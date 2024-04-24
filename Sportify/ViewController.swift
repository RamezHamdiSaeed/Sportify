//
//  ViewController.swift
//  Sportify
//
//  Created by Hadir on 16/04/2024.
//

import UIKit

class ViewController: UIViewController {

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

