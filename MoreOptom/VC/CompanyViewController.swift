//
//  CompanyViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 23.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UtilsSettings.shared.colorBgTint
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UtilsSettings.shared.colorTint]
        self.navigationController?.navigationBar.tintColor = UtilsSettings.shared.colorTint
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
