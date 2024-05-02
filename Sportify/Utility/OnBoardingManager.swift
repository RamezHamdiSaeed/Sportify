//
//  OnBoardingManager.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 23/04/2024.
//

import Foundation
class OnBoardingManager{
    static let shared = OnBoardingManager()
    
    func isNewuser()->Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
