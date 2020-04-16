//
//  MainTableViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 29.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var mainStat: MainStat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainStat().fetchData() { (obj) in
            DispatchQueue.main.async {
                self.mainStat = obj
                self.tableView.reloadData()
                
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellStat", for: indexPath) as! MainStatTableViewCell
            cell.mainStat = mainStat
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFish", for: indexPath) as! MainStatFishTableViewCell
            cell.tovar = mainStat?.tovars[indexPath.row]
            return cell
        }
        
        
        

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var h = 80.0
        if indexPath.row == 0 {
            h = 150.0
        }
        
        return CGFloat(h)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tovar = mainStat?.tovars[indexPath.row] else {return}
        
        UtilsSettings.shared.fishKey = UtilsSettings.shared.getFishKey(from: tovar.fishId)
        UtilsSettings.shared.updatePrice = true
        self.tabBarController?.selectedIndex = 1
    }
    
    // MARK: - Navigation
    @IBAction func actionGoPrice(_ sender: Any) {
        UtilsSettings.shared.updatePrice = true
        self.tabBarController?.selectedIndex = 1
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
