//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Hadir on 26/04/2024.
//

import Foundation

protocol TeamDetailsView{
    func showTeamDetails(_ teamOfPlayers: [TeamOfPlayers])
}

class TeamDetailsPresenter{
    
    private var view: TeamDetailsView?
    
    func attachView(view: TeamDetailsView){
        self.view = view
    }
    
    func getTeamInfo(of sport: Sport, for teamId: String) {
        TeamRepositoryImpl.shared.getTeamInfo(of: sport, for: teamId){[weak self] result in
            switch result {
            case .success(let success):
                self?.view?.showTeamDetails(success.result ?? [])
//                print(result)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
