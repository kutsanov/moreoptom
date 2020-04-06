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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olTableView.estimatedRowHeight = 44.0
        olTableView.rowHeight = UITableView.automaticDimension
        
        
        //olTableView.rowHeight = 40
        
        self.navigationController?.navigationBar.barTintColor = UtilsSettings.shared.colorBgTint
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UtilsSettings.shared.colorTint]
        self.navigationController?.navigationBar.tintColor = UtilsSettings.shared.colorTint
        
    }
    //RGB(0, 109, 218)
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = olTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PriceTableViewCell
        
        if indexPath.row == 2 {
            cell.olNote.text = "dgf lsdf jsd slfh dl dslfh sdlfh slfds kh sldfh sld fsdhl sdl fsldkf sdljfh sdlf sldkfhldf sld sdlfh slf dgf lsdf jsd slfh dl dslfh sdlfh slfds kh sldfh sld fsdhl sdl fsldkf sdljfh sdlf sldkfhldf sld sdlfh slfdgf lsdf jsd slfh dl dslfh sdlfh slfds kh sldfh sld fsdhl sdl fsldkf sdljfh sdlf sldkfhldf sld sdlfh slfdgf lsdf jsd slfh dl dslfh sdlfh slfds kh sldfh sld fsdhl sdl fsldkf sdljfh sdlf sldkfhldf sld sdlfh slf"
        }
                
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
