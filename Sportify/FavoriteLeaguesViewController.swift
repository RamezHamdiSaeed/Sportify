//
//  FavoriteLeaguesViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 24/04/2024.
//

import UIKit

class FavoriteLeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteLeaguesView{

    

    @IBOutlet weak var favoriteTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.favoriteTableView.register(nib, forCellReuseIdentifier: "favoriteSportLeague")
        FavoriteLeaguesPresenter.setupView(tableViewToBeRefreshed: self)
        FavoriteLeaguesPresenter.getLeaguesFromFav() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }
    
    func updateData(leagues: [League]) {
        FavoriteLeaguesPresenter.leaguesDB = leagues
        favoriteTableView.reloadData()
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return FavoriteLeaguesPresenter.leaguesDB.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteSportLeague", for: indexPath) as! LeagueTableViewCell
        let imageUrl = (FavoriteLeaguesPresenter.leaguesDB[indexPath.item].leagueLogo ?? FavoriteLeaguesPresenter.leaguesDB[indexPath.item].countryLogo) ?? "UnKnown"

        cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "AppIcon"))

        let title:String = (FavoriteLeaguesPresenter.leaguesDB[indexPath.item].leagueName ?? FavoriteLeaguesPresenter.leaguesDB[indexPath.item].countryName) ?? "UnKnown"

        cell.leagueName?.text = title
        
        
        return cell
    }
   
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to the first view controller in the Details Story Board
    }


}
