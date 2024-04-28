//
//  TeamDetailsTableViewController.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import UIKit
import NVActivityIndicatorView


class TeamDetailsTableViewController: UITableViewController{

    var teamId: Int!
    var presenter: TeamDetailsPresenter!
    var team = [TeamOfPlayers]()
    var teamPlayers = [Player]()
    var teamCoach = [Coach]()
    let sectionTitles = ["Team", "Coaches", "Players"]
    var activityIndicatorView: NVActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndecator()
        presenter = TeamDetailsPresenter()
        presenter.attachView(view: self)
        presenter.getTeamInfo(of: .football, for: String(teamId))
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "homeSportLeague")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return team.count
        case 1:
            return teamCoach.count
        default:
            return teamPlayers.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeSportLeague", for: indexPath) as! LeagueTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.leagueImage.sd_setImage(with: URL(string: team[indexPath.row].teamLogo ?? ""), placeholderImage: UIImage(named: "AppIcon"))
            cell.leagueName.text = team[indexPath.row].teamName
        case 1:
            var coachName = teamCoach[indexPath.row].coachName
            if coachName == "" {coachName = "Unknown Coach"}
            cell.leagueImage.image = UIImage(systemName: "person.circle.fill")
            cell.leagueName.text = coachName
        default:
            cell.leagueImage.sd_setImage(with: URL(string: teamPlayers[indexPath.row].playerImage ?? ""), placeholderImage: UIImage(systemName: "person.circle.fill"))
            cell.leagueName.text = teamPlayers[indexPath.row].playerName
        }
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           // Return the title for each section
           return sectionTitles[section]
       }

       override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           // Return the height for each section header
           return 40 // Adjust as needed to create space between sections
       }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.tintColor = UIColor(red: 26/255, green: 22/255, blue: 23/255, alpha: 1.0)
        header.textLabel?.textColor = UIColor(red: 0.3686, green: 0.9843, blue: 0.6314, alpha: 1.0)
    }
    func addActivityIndecator(){
            activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .ballScale, color: UIColor(named: "Green"), padding: nil)
            
            view.addSubview(activityIndicatorView)
            
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            activityIndicatorView.startAnimating()
        }



}

extension TeamDetailsTableViewController: TeamDetailsView{
    func showTeamDetails(_ teamOfPlayers: [TeamOfPlayers]) {
        activityIndicatorView.stopAnimating()
        team = teamOfPlayers
        teamPlayers = teamOfPlayers[0].players ?? []
        teamCoach = teamOfPlayers[0].coaches ?? []
        self.tableView.reloadData()
    }
}
