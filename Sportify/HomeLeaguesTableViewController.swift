//
//  HomeLeaguesTableViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import UIKit
import SDWebImage

class HomeLeaguesTableViewController: UITableViewController {
    
    var leaguesNetwork : [League] = [League]()
    var sportChosen : Sport! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "homeSportLeague")

//        leaguesNetwork = GetLeaguesRepo(remoteDataSource: FetchLeaguesNetwork()).getLeaguesNetwork(sport: sportChosen)
        getLeagues(of: sportChosen)
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
        //navigate to the first view controller in the Details Story Board
        // but now just for testing the insertion and navigate to the favorite to test the data retrieving
        LeagueRepositoryImpl.shared.insertLeagueToFav(league: self.leaguesNetwork[indexPath.item])
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getLeagues(of sport: Sport){
         print("getting the leagues...")
         LeagueRepositoryImpl.shared.getLeaguesFromNetwork(of: sport){result in
             switch result{
             case .success(let leagues):
                 //your logic goes here
                 self.leaguesNetwork = leagues.result!
                 self.tableView.reloadData()
                 print(leagues)
             case .failure(let error):
                 //error handling here
                 print(error)
             }
         }
     }
}
