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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure(){
        scrollView.frame = viewHolder.bounds
        viewHolder.addSubview(scrollView)
        let titles = ["Favorite Sports","Sport Leagues","Leagues Matches"]
        for x in 0..<3 {
            
            let page = UIView(frame: CGRect(x: CGFloat(x) * viewHolder.frame.size.width, y: 0, width: viewHolder.frame.size.width, height: viewHolder.frame.size.height))
            
            scrollView.addSubview(page)
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: page.frame.size.width-20, height: 120))
//            let image = UIImageView(frame: CGRect(x: 0, y: 0, width: page.frame.size.width, height: page.frame.size.height))
            let animationView = LottieAnimationView()
                    animationView.animation = LottieAnimation.named("olympic_\(x+1)")
                    animationView.frame = CGRect(x: 0, y: 0, width: page.frame.size.width, height: page.frame.size.height)
                    animationView.loopMode = .loop
                    view.addSubview(animationView)
                    animationView.play()
            
            let button = UIButton(frame: CGRect(x: 10, y: page.frame.size.height-60, width: page.frame.size.width-20, height: 50))
            
            
            animationView.contentMode = .scaleAspectFit
//            image.image = UIImage(named: "Welcome_\(x+1)")
            page.addSubview(animationView)
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            label.text = titles[x]
            page.addSubview(label)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Continue", for: .normal)
            if x == 2 {
                button.setTitle("Get Started", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.tag = x+1
            page.addSubview(button)

            
            scrollView.contentSize = CGSize(width: viewHolder.frame.size.width*3, height: 0)
            scrollView.isPagingEnabled = true
            
            
        }
    }

    @objc func didTapButton(_ button:UIButton){
        guard button.tag < 3 else{
            
            OnBoardingManager.shared.setIsNotNewUser()
            dismiss(animated: true,completion: nil)
            return
        }
        scrollView.setContentOffset(CGPoint(x: viewHolder.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }
    
    
}
