//
//  AppCommon.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 26/04/2024.
//

import UIKit
import Network

class AppCommon{
    public static let shared = AppCommon()
    var sport : Sport?
    private init(){}
    
    
  
    func isOnline()->Bool{
        var online = false
        var monitor: NWPathMonitor?
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = {path in
            online = (path.status == .satisfied)
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor?.start(queue: queue)
        return online
    }
}
