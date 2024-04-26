//
//  HomeLeaguesTableViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import UIKit
import SDWebImage

class HomeLeaguesTableViewController: UITableViewController ,HomeLeaguesView{

    
    
    var leaguesNetwork : [League] = [League]()
    var sportChosen : Sport! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "homeSportLeague")
        
        //        leaguesNetwork = GetLeaguesRepo(remoteDataSource: FetchLeaguesNetwork()).getLeaguesNetwork(sport: sportChosen)
        HomeLeaguesPresenter.getLeaguesFromNetwork(of: sportChosen, tableViewToBeRefreshed: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesNetwork.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeSportLeague", for: indexPath) as! LeagueTableViewCell
        let imageUrl = (self.leaguesNetwork[indexPath.item].leagueLogo ?? self.leaguesNetwork[indexPath.item].countryLogo) ?? "UnKnown"
        
        cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "AppIcon"))
        
        let title:String = (self.leaguesNetwork[indexPath.item].leagueName ?? self.leaguesNetwork[indexPath.item].countryName) ?? "UnKnown"
        
        cell.leagueName?.text = title
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        if let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
            destinationViewController.league = leaguesNetwork[indexPath.row]
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    func updateData(leagues: Leagues) {
        leaguesNetwork = leagues.result ?? [League]()
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$\(leagues)")
        self.tableView.reloadData()
    }

}
