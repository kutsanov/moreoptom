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
    @IBOutlet var olTopFish: UILabel!
    @IBOutlet var olTopType: UILabel!
    @IBOutlet var olTopOblast: UILabel!
    
    private var tovars = [PriceItem]()
    
    private var fetchinMore = false
    private var fetchinEnd = false
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UtilsSettings.shared.colorBgTint
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UtilsSettings.shared.colorTint]
        self.navigationController?.navigationBar.tintColor = UtilsSettings.shared.colorTint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        olTableView.estimatedRowHeight = 44.0
        olTableView.rowHeight = UITableView.automaticDimension        
        olTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let topFish = UtilsSettings.shared.fishName
        olTopFish.text = "Продукция: \(topFish)"
        
        let topType = UtilsSettings.shared.typeName
        olTopType.text = "Тип: \(topType)"
        
        let topOblast = UtilsSettings.shared.oblastName
        olTopOblast.text = "Область: \(topOblast)"
        
        if UtilsSettings.shared.updatePrice == true {
            currentPage = 1
            Price().fetchData(with: currentPage) { (obj) in
                DispatchQueue.main.async {
                    self.tovars = obj.tovars ?? []
                    self.olTableView.reloadData()
                    self.fetchinMore = false
                }
            }
            
            UtilsSettings.shared.updatePrice = false
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
        
        if contentHeight == 0 {
            return
        }
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchinMore {
                fetchData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tovar = tovars[indexPath.row]
        performSegue(withIdentifier: "segueViewTovar", sender: tovar)
    }
    
    private func fetchData() {
        fetchinMore = true
        currentPage += 1
        olTableView.reloadSections(IndexSet(integer: 1), with: .none)
        Price().fetchData(with: currentPage) { (obj) in
            DispatchQueue.main.async {
                let tovars = obj.tovars ?? []
                if tovars.count > 0 {
                    self.tovars.append(contentsOf: tovars)
                    self.fetchinMore = false
                } else {
                    self.fetchinEnd = true
                }
                self.olTableView.reloadData()
            }
            UtilsSettings.shared.updatePrice = false
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueViewTovar" {
            let tovarVC = segue.destination as! TovarViewController
            guard let priceItem = sender as? PriceItem else { return }
            tovarVC.priceItem = priceItem
        }
    }
    
}
