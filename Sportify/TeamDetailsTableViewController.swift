//
//  TeamDetailsTableViewController.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import UIKit

protocol TeamDetailsView{
    func showTeamDetails(_ teamOfPlayers: [TeamOfPlayers])
}

class TeamDetailsTableViewController: UITableViewController{

    var teamId: Int!
    var presenter: TeamDetailsPresenter!
    var team = [TeamOfPlayers]()
    var teamPlayers = [Player]()
    var teamCoach = [Coach]()
    let sectionTitles = ["Team", "Coaches", "Players"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        header.textLabel?.textColor = UIColor.systemGreen
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension TeamDetailsTableViewController: TeamDetailsView{
    func showTeamDetails(_ teamOfPlayers: [TeamOfPlayers]) {
        team = teamOfPlayers
        teamPlayers = teamOfPlayers[0].players ?? []
        teamCoach = teamOfPlayers[0].coaches ?? []
        self.tableView.reloadData()
    }
}
