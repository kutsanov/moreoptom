//
//  PrefTableViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 22.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class PricePrefTableViewController: UITableViewController {
    
    @IBOutlet var olTitleType: UILabel!
    @IBOutlet var olTitleFish: UILabel!
    @IBOutlet var olTitleOblast: UILabel!
    
    
    var dataForPicker = [UtilsSelectOption]()
    
    var changeSelect = ""
    
    var selectKey = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olTitleType.text = UtilsSettings.shared.typeName
        olTitleFish.text = UtilsSettings.shared.fishName
        olTitleOblast.text = UtilsSettings.shared.oblastName
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellId = cell?.reuseIdentifier else {return}
        
        var data = [UtilsSelectOption]()
        changeSelect = cellId
        
        switch cellId {
        case "cellType":
            data = UtilSelect.shared.typeLst()
            selectKey = UtilsSettings.shared.typeKey
            break
        case "cellFish":
            data = UtilSelect.shared.fishLst()
            selectKey = UtilsSettings.shared.fishKey
            break
        case "cellOblast":
            data = UtilSelect.shared.oblastLst()
            selectKey = UtilsSettings.shared.oblastKey
            break
        default:
            break
        }
        
        dataForPicker = data
        
        showPickerInActionSheet()
    }
    
}

extension PricePrefTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        switch changeSelect {
        case "cellType":
            UtilsSettings.shared.typeKey = row
            olTitleType.text = UtilsSettings.shared.typeName
            break
        case "cellFish":
            UtilsSettings.shared.fishKey = row
            olTitleFish.text = UtilsSettings.shared.fishName
            break
        case "cellOblast":
            UtilsSettings.shared.oblastKey = row
            olTitleOblast.text = UtilsSettings.shared.oblastName
            break
        default:
            break
        }
        UtilsSettings.shared.updateDataTrue()
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
        
        pickerView.selectRow(selectKey, inComponent: 0, animated: true)
        
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
