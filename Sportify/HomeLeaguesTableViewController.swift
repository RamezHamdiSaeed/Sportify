//
//  HomeLeaguesTableViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import UIKit
import SDWebImage

class HomeLeaguesTableViewController: UITableViewController {
    
    var leaguesNetwork : Leagues! = nil
    var sportChosen : Sport! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "homeSportLeague")

        leaguesNetwork = GetLeaguesRepo(remoteDataSource: FetchLeaguesNetwork()).getLeaguesNetwork(sport: sportChosen)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesNetwork.result!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeSportLeague", for: indexPath)
        
        let imageUrl = (self.leaguesNetwork.result![indexPath.item].league_logo ?? self.leaguesNetwork.result![indexPath.item].country_logo) ?? "UnKnown"
        
        cell.imageView?.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "AppIcon"))
        
        let title:String = (self.leaguesNetwork.result![indexPath.item].league_name ?? self.leaguesNetwork.result![indexPath.item].country_name) ?? "UnKnown"
        
        cell.textLabel?.text = title
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
