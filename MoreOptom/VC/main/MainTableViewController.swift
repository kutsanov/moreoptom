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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellStat", for: indexPath) as! MainStatTableViewCell
            cell.mainStat = mainStat
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
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
        
        let data = UtilSelect.shared.fishLst()
        
        for i in 0..<data.count {
            let fish = data[i] as UtilsSelectOption
            if fish.id == tovar.fishId {
                UtilsSettings.shared.fishKey = i
                break
            }
        }
        
        guard let tabBarController: UITabBarController = self.view.window?.rootViewController as? UITabBarController else {return}
        tabBarController.selectedIndex = 1

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
