//
//  HomeViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 24/04/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    let sports = [SportCategory(name: "Football", image: "footBall"),SportCategory(name: "BasketBall", image: "basketBall"),SportCategory(name: "Cricket", image: "cricket"),SportCategory(name: "Tennis", image: "tennis")]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "sportCollectionViewCell", bundle: nil)
        self.sportsCollectionView.register(nib, forCellWithReuseIdentifier: "sportCell")
    }
    
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"sportCell", for: indexPath) as! SportCollectionViewCell
        cell.backgroundColor = .systemTeal
        let sportImage = self.sports[indexPath.item].image
        let sportName = self.sports[indexPath.item].name
       cell.image.image = UIImage(named: sportImage)
        cell.sportName.text = sportName
        cell.backgroundColor = UIColor(named: "btn_cells_tabBar")
        cell.layer.cornerRadius = 20
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.sportsCollectionView.frame.width/2, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 70
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeLeaguesTableVC:HomeLeaguesTableViewController = HomeLeaguesTableViewController()
        let sportName:String = self.sports[indexPath.item].name
        var sportNameEnum: Sport?
        switch sportName{
        case "Football":
            sportNameEnum = .football
        case "BasketBall":
            sportNameEnum = .basketball
        case "Cricket":
            sportNameEnum = .cricket
        default:
            sportNameEnum = .tennis

        }
        AppCommon.shared.sport = sportNameEnum
        homeLeaguesTableVC.sportChosen = sportNameEnum
        self.navigationController?.pushViewController(homeLeaguesTableVC, animated: true)
        
    }
    
}
