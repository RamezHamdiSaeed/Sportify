//
//  AppCommon.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 26/04/2024.
//

import UIKit
import Reachability

class AppCommon{
    
    public static let shared = AppCommon()
    var sport : Sport?
    private let reachability = try! Reachability()
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        reachability.whenReachable = { _ in
            print("Network is reachable")
        }
        reachability.whenUnreachable = { _ in
            print("No Network!!")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func isNetworkReachable() -> Bool {
        return reachability.connection != .unavailable
    }
    
    func showSimpleAlert(title: String = "Error", message: String, view: UIViewController, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    handler?()
                }
        alertController.addAction(okAction)
        
        view.present(alertController, animated: true, completion: nil)
        
    }
    
}
