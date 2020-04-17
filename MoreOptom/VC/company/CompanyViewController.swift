//
//  CompanyViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 23.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var olTopOblast: UILabel!
    @IBOutlet var olTable: UITableView!
    
    var comppanys = [CompanyItem]()
    
    var fnd: String = ""
    
    private var fetchinMore = false
    private var fetchinEnd = false
    private var currentPage = 0
    private var flagReloadSection = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UtilsSettings.shared.colorBgTint
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UtilsSettings.shared.colorTint]
        self.navigationController?.navigationBar.tintColor = UtilsSettings.shared.colorTint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let topOblast = UtilsSettings.shared.oblastName
        olTopOblast.text = "Область: \(topOblast)"
        
        if UtilsSettings.shared.updateCompany == true {
            comppanys = [CompanyItem]()
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
            return comppanys.count
        } else if section == 1 && fetchinMore && !fetchinEnd {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let company = comppanys[indexPath.row]
            let cell = olTable.dequeueReusableCell(withIdentifier: "cellCompany", for: indexPath) as! CompanyTableViewCell
            cell.company = company
            return cell
        } else {
            let cell = olTable.dequeueReusableCell(withIdentifier: "cellLoading", for: indexPath) as! SpinerTableViewCell
            cell.olSpiner.startAnimating()
            return cell
        }
        
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
            olTable.reloadSections(IndexSet(integer: 1), with: .none)
        }
        flagReloadSection = true
        Company().fetchData(with: currentPage, with: fnd) { (obj) in
            DispatchQueue.main.async {
                let comppanys = obj
                if comppanys.count > 0 {
                    self.comppanys.append(contentsOf: comppanys)
                    self.fetchinMore = false
                } else {
                    self.fetchinEnd = true
                }
                self.olTable.reloadData()
            }
            UtilsSettings.shared.updateCompany = false
        }
    }
}
