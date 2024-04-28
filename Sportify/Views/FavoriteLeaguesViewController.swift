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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "backgroundColor")
        FavoriteLeaguesPresenter.getLeaguesFromFav() 
        favoriteTableView.reloadData()
    }
    
    func updateData(leagues: [League]) {
        print(leagues.count)
        FavoriteLeaguesPresenter.leaguesDB = leagues
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print(FavoriteLeaguesPresenter.leaguesDB.count)
         return FavoriteLeaguesPresenter.leaguesDB.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteSportLeague", for: indexPath) as! LeagueTableViewCell
         let imageUrl = (FavoriteLeaguesPresenter.leaguesDB[indexPath.row].leagueLogo ?? FavoriteLeaguesPresenter.leaguesDB[indexPath.row].countryLogo) ?? "UnKnown"
         print("image paths is $$$$$$$$$$$$$$:::::::\(FavoriteLeaguesPresenter.leaguesDB[indexPath.row].leagueLogo)")
         
         print("image paths is $$$$$$$$$$$$$$:::::::\(FavoriteLeaguesPresenter.leaguesDB[indexPath.row].countryLogo)")
         
        cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named:
                                                                                                "AppIcon"))


        cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "img_launcher"))

        let title:String = (FavoriteLeaguesPresenter.leaguesDB[indexPath.item].leagueName ?? FavoriteLeaguesPresenter.leaguesDB[indexPath.item].countryName) ?? "UnKnown"

        cell.leagueName?.text = title
        
        
        return cell
    }
   
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to the first view controller in the Details Story Board
         let storyboard = UIStoryboard(name: "Details", bundle: nil)
         
         if let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
             destinationViewController.league = FavoriteLeaguesPresenter.leaguesDB[indexPath.row]
             navigationController?.pushViewController(destinationViewController, animated: true)
         }
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let index = indexPath.row
            let leagueToBeRemoved = FavoriteLeaguesPresenter.leaguesDB[index]
            print("index is $$$$$$$$ ::::::\(index)")
            FavoriteLeaguesPresenter.deleteLeagueFromFav(league: leagueToBeRemoved)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }


}
