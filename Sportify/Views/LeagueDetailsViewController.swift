//
//  LeagueDetailsViewController.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class LeagueDetailsViewController: UIViewController{
    
    var presenter: LeagueDetailsPresenter!
    @IBOutlet var detailsCollectionView: UICollectionView!
    var activityIndicatorView: NVActivityIndicatorView!
    
    @IBOutlet var favButton: UIBarButtonItem!
    var placeholderLabel: UILabel!
    
    var sectionTitles = ["Upcoming Events", "Latest Results", "Teams"]
    var upcomingEvents = [Event]()
    var latestEvents = [Event]()
    var teams = [Team]()
    var league: League!
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndecator()
        presenter = LeagueDetailsPresenter()
        presenter.attachView(view: self)
        setupPlaceholderLabel()
        setupCollectionView()
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFavButton()
        view.backgroundColor = .systemGray
        
    }
    
    
    @IBAction func toggleFavPressed(_ sender: UIBarButtonItem) {
        if isFavorite {
            presenter.deleteFromFav(league: league)
        }else{
            presenter.addToFav(league: league)
        }
        isFavorite.toggle()
        setupFavButton()
        
    }
    
    private func setupCollectionView(){
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        var nib = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
        detailsCollectionView.register(nib, forCellWithReuseIdentifier: "detailsCell")
        nib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        detailsCollectionView.register(nib, forCellWithReuseIdentifier: "teamCell")
        detailsCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        
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
    
    private func setupFavButton(){
        isFavorite = presenter.isFav(league: league)
        if isFavorite{
            favButton.image = UIImage(systemName: "heart.fill")
        }else{
            favButton.image = UIImage(systemName: "heart")
        }
    }
    
    private func addActivityIndecator(){
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballRotateChase, color: UIColor(named: "Green"), padding: nil)
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0)
        ])
        view.bringSubviewToFront(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
    }
    
    private func setupPlaceholderLabel() {
        placeholderLabel = UILabel()
        placeholderLabel.text = "No items available"
        placeholderLabel.textAlignment = .center
        placeholderLabel.textColor = .gray
        placeholderLabel.isHidden = true
        
        view.addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}


extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if upcomingEvents.isEmpty {
                placeholderLabel.isHidden = false
                return 0
            } else {
                placeholderLabel.isHidden = true
                return upcomingEvents.count
            }
        case 1:
            if latestEvents.isEmpty {
                placeholderLabel.isHidden = false
                return 0
            } else {
                placeholderLabel.isHidden = true
                return latestEvents.count
            }
        case 2:
            if teams.isEmpty {
                placeholderLabel.isHidden = false
                return 0
            } else {
                placeholderLabel.isHidden = true
                return teams.count
            }
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as? LeagueDetailsCollectionViewCell else {fatalError("Unable deque cell...")}
            let cellData = upcomingEvents[indexPath.row]
            if AppCommon.shared.sport == .tennis{
                
            }else{
                cell.firstTeamNameLabel.text = cellData.eventHomeTeam ?? "Team name"
                cell.firstTeamLogo.sd_setImage(with: URL(string: cellData.eventHomeTeamLogo ?? ""), placeholderImage: UIImage(named: "img_launcher"))
                cell.secondTeamNameLabel.text = cellData.eventAwayTeam ?? "Team name"
                cell.secondTeamLogo.sd_setImage(with: URL(string: cellData.eventAwayTeamLogo ?? ""), placeholderImage: UIImage(named: "img_launcher"))
                
            }
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
            cell.firstTeamLogo.sd_setImage(with: URL(string: cellData.eventHomeTeamLogo ?? ""), placeholderImage: UIImage(named: "img_launcher"))
            cell.secondTeamNameLabel.text = cellData.eventAwayTeam ?? "Team name"
            cell.secondTeamLogo.sd_setImage(with: URL(string: cellData.eventAwayTeamLogo ?? ""), placeholderImage: UIImage(named: "img_launcher"))
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
            cell.teamLogo.sd_setImage(with: URL(string: team.teamLogo ?? ""), placeholderImage: UIImage(named: "img_launcher"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard AppCommon.shared.isNetworkReachable() else {
            AppCommon.shared.showSimpleAlert(title:"Network Error", message: "Oops! Something went wrong with the network. Please check your internet connection and try again.",view: self)
            return
        }
        if AppCommon.shared.sport == .football && indexPath.section == 2 {
            let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsTableViewController") as! TeamDetailsTableViewController
            destinationViewController.teamId = teams[indexPath.row].teamKey ?? 0
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }else if indexPath.section == 2{
            AppCommon.shared.showSimpleAlert(title:"Team Details Unavailable", message: "Sorry, team details for this sport are currently unavailable. We're working on bringing them to you soon. Please check back later.",view: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
            fatalError("Failed to dequeue SectionHeaderView")
        }
        
        headerView.tintColor = UIColor(red: 26/255, green: 22/255, blue: 23/255, alpha: 1.0)
        headerView.titleLabel.text = sectionTitles[indexPath.section]
        headerView.titleLabel.textColor = UIColor(red: 0.3686, green: 0.9843, blue: 0.6314, alpha: 1.0)
        
        return headerView
    }
    
    
}



extension LeagueDetailsViewController: LeagueDetailsView{
    func showUpcomingEvents(events: [Event]?) {
        if activityIndicatorView.isAnimating{
            activityIndicatorView.stopAnimating()
        }
        upcomingEvents = events?.reversed() ?? []
        detailsCollectionView.reloadData()
    }
    
    func showLatestEvents(events: [Event]?) {
        if activityIndicatorView.isAnimating{
            activityIndicatorView.stopAnimating()
        }
        latestEvents = events ?? []
        detailsCollectionView.reloadData()
    }
    
    func showTeams(teams: [Team]?) {
        if activityIndicatorView.isAnimating{
            activityIndicatorView.stopAnimating()
        }
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
    
    
}

extension LeagueDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}


