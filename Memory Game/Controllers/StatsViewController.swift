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
            PlayerStats.stats = playerStats
            playerStatsArray = Array(playerStats.keys).sorted()
                
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playerStatsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stat = playerStatsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell

        cell.playerStat.text = stat
        cell.count.text = String(PlayerStats.stats[stat]!)

        return cell
    }
}

    
  



 


