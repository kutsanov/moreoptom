//
//  BoardViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 23.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var olTableView: UITableView!
    @IBOutlet var olTopOblast: UILabel!
    @IBOutlet var olTopType: UILabel!
    
    private var tovars = [BoardProviderItem]()
    private var fetchinMore = false
    private var fetchinEnd = false
    private var currentPage = 1
    
    private var flagReloadSection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UtilsSettings.shared.colorBgTint
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UtilsSettings.shared.colorTint]
        self.navigationController?.navigationBar.tintColor = UtilsSettings.shared.colorTint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let topType = UtilsSettings.shared.boardTypeName
        olTopType.text = "Тип: \(topType)"
        
        let topOblast = UtilsSettings.shared.oblastName
        olTopOblast.text = "Область: \(topOblast)"
        
        if UtilsSettings.shared.updateBoard == true {
            tovars = [BoardProviderItem]()
            flagReloadSection = false
            currentPage = 0
            updateTable()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tovars.count
        } else if section == 1 && fetchinMore && !fetchinEnd {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let tovar = tovars[indexPath.row]
            
            if tovar.photo == nil {
                let cell = olTableView.dequeueReusableCell(withIdentifier: "cellBoard", for: indexPath) as! BoardTableViewCell
                cell.tovar = tovar
                return cell
            } else {
                let cell = olTableView.dequeueReusableCell(withIdentifier: "cellBoardPhoto", for: indexPath) as! BoardTableViewCell
                cell.tovar = tovar
                return cell
            }
        } else {
            let cell = olTableView.dequeueReusableCell(withIdentifier: "cellLoading", for: indexPath) as! SpinerTableViewCell
            cell.olSpiner.startAnimating()
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tovars[indexPath.row]
        performSegue(withIdentifier: "segueViewItem", sender: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        olTableView.layoutIfNeeded()
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentHeight == 0 {
            return
        }
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchinMore {
                updateTable()
            }
        }
    }
    
    private func updateTable() {
        fetchinMore = true
        currentPage += 1
        if flagReloadSection == true {
            olTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        BoardProvider().fetchData(with: currentPage) { (obj) in
            DispatchQueue.main.async {
                let tovars = obj.tovars
                if tovars.count > 0 {
                    self.tovars.append(contentsOf: tovars)
                    self.fetchinMore = false
                } else {
                    self.fetchinEnd = true
                }
                self.olTableView.reloadData()
            }
            UtilsSettings.shared.updateBoard = false
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueViewItem" {
            let tovarVC = segue.destination as! BoardItemViewController
            guard let tovarItem = sender as? BoardProviderItem else { return }
            tovarVC.itemIn = tovarItem
        }
    }
}
