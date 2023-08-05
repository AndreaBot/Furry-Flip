//
//  StatsViewController.swift
//  Furry Flip
//
//  Created by Andrea Bottino on 04/08/2023.
//

import UIKit

class StatsViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var playerStatsArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        if let playerStats = defaults.object(forKey: "playerStats") as? [String : Int] {
            PlayerStats.overallStats = playerStats
            playerStatsArray = Array(playerStats.keys).sorted()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if playerStatsArray == [] {
            return 1
        } else {
            return playerStatsArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        if playerStatsArray == [] {
            cell.playerStat.text = "👻 Oops! Nothing to see here, yet. Start playing to see your stats!"
            cell.playerStat.numberOfLines = 2
            cell.playerStat.adjustsFontSizeToFitWidth = true
            cell.playerStat.textAlignment = .center
            cell.count.isHidden = true
        } else {
            let stat = playerStatsArray[indexPath.row]
            cell.playerStat.text = stat
            cell.count.text = String(PlayerStats.overallStats[stat]!)
        }
        return cell
    }
}


    
  



 


