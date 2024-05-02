//
//  WelcomeViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 23/04/2024.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController {

    @IBOutlet weak var viewHolder: UIView!
    let scrollView = UIScrollView()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !OnBoardingManager.shared.isNewuser() {
            performSegue(withIdentifier: "welcomeToHome", sender: self)
        }
        configure()
    }
    
    private func configure(){
        scrollView.frame = viewHolder.bounds
        scrollView.backgroundColor = UIColor(red: 26/255, green: 22/255, blue: 23/255, alpha: 1.0)
        viewHolder.addSubview(scrollView)
        let titles = ["Favorite Sports","Leagues and Matches"]
        for x in 0..<2 {
            
            let page = UIView(frame: CGRect(x: CGFloat(x) * viewHolder.frame.size.width, y: 0, width: viewHolder.frame.size.width, height: viewHolder.frame.size.height))
            
            scrollView.addSubview(page)
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: page.frame.size.width-20, height: 120))
            let animationView = LottieAnimationView()
                    animationView.animation = LottieAnimation.named("olympic_\(x+1)")
                    animationView.frame = CGRect(x: 0, y: 0, width: page.frame.size.width, height: page.frame.size.height)
                    animationView.loopMode = .loop
                    view.addSubview(animationView)
                    animationView.play()
            
            let button = UIButton(frame: CGRect(x: 10, y: page.frame.size.height-60, width: page.frame.size.width-20, height: 50))
            
            
            animationView.contentMode = .scaleAspectFit
            page.addSubview(animationView)
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            label.textColor = UIColor.white
            label.text = titles[x]
            page.addSubview(label)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .darkGray
            button.setTitle("Continue", for: .normal)
            if x == 1 {
                button.setTitle("Get Started", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.tag = x+1
            page.addSubview(button)

            
            scrollView.contentSize = CGSize(width: viewHolder.frame.size.width*2, height: 0)
            scrollView.isPagingEnabled = true
            
            
        }
    }

    @objc func didTapButton(_ button:UIButton){
        guard button.tag < 2 else{
            OnBoardingManager.shared.setIsNotNewUser()
            performSegue(withIdentifier: "welcomeToHome", sender: self)
            return
        }
        scrollView.setContentOffset(CGPoint(x: viewHolder.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }
    
    
}
