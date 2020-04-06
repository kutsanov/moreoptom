//
//  CompanyPrefTableViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 23.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class CompanyPrefTableViewController: UITableViewController {
    @IBOutlet var olTitleOblast: UILabel!
    
    var dataForPicker = [UtilsSelectOption]()
    var changeSelect = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olTitleOblast.text = UtilsSettings.shared.oblastName


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellId = cell?.reuseIdentifier else {return}
        
        var data = [UtilsSelectOption]()
        changeSelect = cellId
        
        switch cellId {
        case "cellOblast":
            data = UtilSelect.shared.oblastLst()
            break
        default:
            break
        }
        
        dataForPicker = data
        
        showPickerInActionSheet()
    }
}


extension CompanyPrefTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        print(changeSelect)
        
        switch changeSelect {
        case "cellOblast":
            UtilsSettings.shared.oblastKey = row
            olTitleOblast.text = UtilsSettings.shared.oblastName
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
