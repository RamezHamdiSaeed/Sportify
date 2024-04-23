//
//  ViewController.swift
//  Sportify
//
//  Created by Hadir on 16/04/2024.
//

import UIKit
import SwiftyOnboard

class ViewController: UIViewController, SwiftyOnboardDataSource {
//    var visitedPages = -1;
//    let onBoardingPages : [OnBoardingPage] = [OnBoardingPage(title: "first Page", subtitle: "lorem ipsum"), OnBoardingPage(title: "second Page", subtitle: "lorem ipsum")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
    }

    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
               return 3
           }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
               let page = SwiftyOnboardPage()
//        visitedPages += 1
//        page.title.text = onBoardingPages[index].title
//        page.subTitle.text = onBoardingPages[index].subtitle
               return page
           }

}

