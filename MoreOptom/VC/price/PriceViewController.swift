//
//  PriceViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 21.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var olTableView: UITableView!
    
    private var tovars = [PriceItem]()
    
    private var fetchinMore = false
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olTableView.estimatedRowHeight = 44.0
        olTableView.rowHeight = UITableView.automaticDimension
        
        olTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationController?.navigationBar.barTintColor = UtilsSettings.shared.colorBgTint
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UtilsSettings.shared.colorTint]
        self.navigationController?.navigationBar.tintColor = UtilsSettings.shared.colorTint
        
        Price().fetchData(with: currentPage) { (obj) in
            DispatchQueue.main.async {
                self.tovars = obj.tovars ?? []
                self.olTableView.reloadData()
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tovars.count
        } else if section == 1 && fetchinMore {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let tovar = tovars[indexPath.row]
            
            if tovar.photo == nil {
                let cell = olTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PriceTableViewCell
                cell.tovar = tovar
                return cell
            } else {
                let cell = olTableView.dequeueReusableCell(withIdentifier: "cellPhoto", for: indexPath) as! PriceTableViewCell
                cell.tovar = tovar
                return cell
            }
        } else {
            let cell = olTableView.dequeueReusableCell(withIdentifier: "cellLoading", for: indexPath) as! SpinerTableViewCell
            cell.olSpiner.startAnimating()
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchinMore {
                fetchData()
            }
            
        }
    }
    
    private func fetchData() {
        fetchinMore = true
        currentPage += 1
        olTableView.reloadSections(IndexSet(integer: 1), with: .none)
        Price().fetchData(with: currentPage) { (obj) in
            DispatchQueue.main.async {
                let tovars = obj.tovars ?? []
                self.tovars.append(contentsOf: tovars)
                self.olTableView.reloadData()
                self.fetchinMore = false
            }
        }
    }
    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
