//
//  HomeLeaguesTableViewController.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView


class HomeLeaguesTableViewController: UITableViewController ,HomeLeaguesView{
    
    var activityIndicatorView: NVActivityIndicatorView!
    
    var leaguesNetwork : [League] = [League]()
    var sportChosen : Sport! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndecator()
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "homeSportLeague")
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
        
        cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "img_launcher"))
        
        let title:String = (self.leaguesNetwork[indexPath.item].leagueName ?? self.leaguesNetwork[indexPath.item].countryName) ?? "UnKnown"
        
        cell.leagueName?.text = title
        cell.backgroundColor = UIColor(named: "btn_cells_tabBar")
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        if AppCommon.shared.sport == .tennis{
            AppCommon.shared.showSimpleAlert(title:"League Details Unavailable", message: "Sorry, league details for this sport are currently unavailable. We're working on bringing them to you soon. Please check back later.",view: self)
        }else{
            if let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
                destinationViewController.league = leaguesNetwork[indexPath.row]
                navigationController?.pushViewController(destinationViewController, animated: true)
            }
        }
        
        
    }
    
    func updateData(leagues: Leagues) {
        activityIndicatorView.stopAnimating()
        leaguesNetwork = leagues.result ?? [League]()
        self.tableView.reloadData()
    }
    
    func addActivityIndecator() {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballRotateChase, color: UIColor(named: "Green"), padding: nil)
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0.0),
            activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0.0)
        ])
        view.bringSubviewToFront(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
    }
    
}
