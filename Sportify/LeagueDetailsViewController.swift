//
//  LeagueDetailsViewController.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import UIKit
import SDWebImage

class LeagueDetailsViewController: UIViewController{
    
    var presenter: LeagueDetailsPresenter!
    @IBOutlet var detailsCollectionView: UICollectionView!
    var upcomingEvents = [Event]()
    var latestEvents = [Event]()
    var teams = [Team]()
    var league: League!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LeagueDetailsPresenterImpl(view: self)
        setupCollectionView()
        getData()
        getLeagues(of: .football, for: "96")

        
    }
    
    
    @IBAction func toggleFavPressed(_ sender: UIBarButtonItem) {
        //Will check first if it is favorite or not
        presenter.addToFav(league: league)
    }
    
    private func setupCollectionView(){
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        var nib = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
        detailsCollectionView.register(nib, forCellWithReuseIdentifier: "detailsCell")
        nib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        detailsCollectionView.register(nib, forCellWithReuseIdentifier: "teamCell")
        configureCompositionalLayout()
    }
    
    private func configureCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return AppLayouts.getUpcomingEventsSection()
            case 1 :
                return AppLayouts.getRecentResultsSection()
            default :
                return AppLayouts.getTeamsSection()
            }
        }
        detailsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
}


extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return upcomingEvents.count
        case 1 :
            return latestEvents.count
        default:
            return teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as? LeagueDetailsCollectionViewCell else {fatalError("Unable deque cell...")}
            let cellData = upcomingEvents[indexPath.row]
            cell.firstTeamNameLabel.text = cellData.eventHomeTeam ?? "Team name"
            cell.firstTeamLogo.sd_setImage(with: URL(string: cellData.eventHomeTeamLogo ?? ""), placeholderImage: UIImage(named: "AppIcon"))
            cell.secondTeamNameLabel.text = cellData.eventAwayTeam ?? "Team name"
            cell.secondTeamLogo.sd_setImage(with: URL(string: cellData.eventAwayTeamLogo ?? ""), placeholderImage: UIImage(named: "AppIcon"))
            cell.timeLabel.text = cellData.eventTime ?? ""
            cell.dateLabel.text = ""
            if let date = cellData.eventDate{
                cell.scoreLabel.text = reformateDate(date)
            }else{
                cell.scoreLabel.text = ""
            }
            
            return cell
        case 1 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as? LeagueDetailsCollectionViewCell else {fatalError("Unable deque cell...")}
            let cellData = latestEvents[indexPath.row]
            cell.firstTeamNameLabel.text = cellData.eventHomeTeam ?? "Team name"
            cell.firstTeamLogo.sd_setImage(with: URL(string: cellData.eventHomeTeamLogo ?? ""), placeholderImage: UIImage(named: "AppIcon"))
            cell.secondTeamNameLabel.text = cellData.eventAwayTeam ?? "Team name"
            cell.secondTeamLogo.sd_setImage(with: URL(string: cellData.eventAwayTeamLogo ?? ""), placeholderImage: UIImage(named: "AppIcon"))
            cell.timeLabel.text = cellData.eventTime ?? ""
            if let date = cellData.eventDate{
                cell.dateLabel.text = reformateDate(date)
            }else{
                cell.dateLabel.text = ""
            }
            cell.scoreLabel.text = cellData.eventFinalResult ?? ""
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? TeamsCollectionViewCell else {fatalError("Unable deque cell...")}
            let team = teams[indexPath.row]
            cell.nameLabel.text = team.teamName
            cell.teamLogo.sd_setImage(with: URL(string: team.teamLogo ?? ""), placeholderImage: UIImage(named: "AppIcon"))
            return cell
        }
    }
    
}

extension LeagueDetailsViewController: LeagueDetailsView{
    func showUpcomingEvents(events: [Event]?) {
        upcomingEvents = events?.reversed() ?? []
        detailsCollectionView.reloadData()
    }
    
    func showLatestEvents(events: [Event]?) {
        latestEvents = events ?? []
        detailsCollectionView.reloadData()
    }
    
    func showTeams(teams: [Team]?) {
        self.teams = teams ?? []
        detailsCollectionView.reloadData()
    }
    
    private func getData(){
        guard let sport = AppCommon.shared.sport else{
            print("Sport type is not provided")
            return
        }
        presenter.getUpcomingEvents(of: sport, for: String(league.leagueKey ?? 0))
        presenter.getLatestResults(of: sport, for: String(league.leagueKey ?? 0))
        presenter.getTeams(of: sport, for: String(league.leagueKey ?? 0))
    }
    
    private func reformateDate(_ dateString: String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            print("Error: Unable to parse the date.")
            return ""
        }
        dateFormatter.dateFormat = "MM/dd"
        let reformattedDate = dateFormatter.string(from: date)
        return reformattedDate
    }
    func getLeagues(of sport: Sport, for teamId: String){
        print("getting the leagues...")
        TeamRepositoryImpl.shared.getTeamInfo(of: sport, for: teamId){
            result in
                switch result{
                case .success(let teamPlayers):
                    //your logic goes here
                    print(" Team Players are ::::::::\(teamPlayers.result![0].players![0])")
                case .failure(let error):
                    //error handling here
                    print("error is ::::::\(error.localizedDescription)")

                }
        }

    }

}

