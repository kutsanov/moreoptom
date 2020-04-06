//
//  BoardPrefTableViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 23.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class BoardPrefTableViewController: UITableViewController {
    @IBOutlet var olTitleOblast: UILabel!
    @IBOutlet var olTitleType: UILabel!
    
    var dataForPicker = [UtilsSelectOption]()
    
    var changeSelect = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olTitleOblast.text = UtilsSettings.shared.oblastName
        olTitleType.text = UtilsSettings.shared.boardTypeName

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellId = cell?.reuseIdentifier else {return}
        
        var data = [UtilsSelectOption]()
        changeSelect = cellId
        
        switch cellId {
        case "cellType":
            data = UtilSelect.shared.boardTypeLst()
            break
        case "cellOblast":
            data = UtilSelect.shared.oblastLst()
            break
        default:
            break
        }
        
        dataForPicker = data
        
        showPickerInActionSheet()
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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


extension BoardPrefTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataForPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataForPicker[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.dismiss(animated: false, completion: nil)
        //UtilsSettings.shared.typeKey = row
        
        switch changeSelect {
        case "cellOblast":
            UtilsSettings.shared.oblastKey = row
            olTitleOblast.text = UtilsSettings.shared.oblastName
            break
        case "cellType":
            UtilsSettings.shared.boardTypeKey = row
            olTitleType.text = UtilsSettings.shared.boardTypeName
            break
        default:
            break
        }
        self.tableView.reloadData()
        
    }
    
    func showPickerInActionSheet() {
        
        let message = "\n\n\n\n\n\n\n\n"
        let alert = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        alert.isModalInPopover = true
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.frame.size.width = alert.view.frame.size.width - 15
        
        alert.view.addSubview(pickerView)
        
        let saveAction = UIAlertAction(title: "Выбрать", style: .default) { (_) -> Void in
            
        }
        
        alert.addAction(saveAction)
        
        for subView in alert.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
        
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
