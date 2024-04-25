//
//  FavoriteLeaguesViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 24/04/2024.
//

import UIKit

class FavoriteLeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewsRefresherDB{

    

    @IBOutlet weak var favoriteTableView: UITableView!
    var leaguesDB : [League] = [League]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.favoriteTableView.register(nib, forCellReuseIdentifier: "favoriteSportLeague")
        LeagueRepositoryImpl.shared.setupViewToBeUpdated(tableViewToBeRefreshed: self)
        LeagueRepositoryImpl.shared.getLeaguesFromFav() 
    }
    func updateData(leagues: [League]) {
        leaguesDB = leagues
        favoriteTableView.reloadData()
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesDB.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteSportLeague", for: indexPath) as! LeagueTableViewCell
        let imageUrl = (self.leaguesDB[indexPath.item].leagueLogo ?? self.leaguesDB[indexPath.item].countryLogo) ?? "UnKnown"

        cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "AppIcon"))

        let title:String = (self.leaguesDB[indexPath.item].leagueName ?? self.leaguesDB[indexPath.item].countryName) ?? "UnKnown"

        cell.leagueName?.text = title
        
        
        return cell
    }
   
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to the first view controller in the Details Story Board
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


}
