//
//  CompanyTableViewCell.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 16.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    @IBOutlet var olName: UILabel!
    @IBOutlet var olOblast: UILabel!
    @IBOutlet var olPhone: UILabel!
    @IBOutlet var olUrl: UIImageView!
    
    var company: CompanyItem!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.traitCollection.userInterfaceStyle == .dark {
            olUrl.image = #imageLiteral(resourceName: "openUrl-white")
        }

    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        olName.text = company.name
        olOblast.text = "\(company.regionName), \(company.cityName)"
        olPhone.text = company.phone
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CompanyTableViewCell.tapUrl))
        olUrl.addGestureRecognizer(tap)
    }
    
        @objc func tapUrl(sender:UITapGestureRecognizer) {
            print(company.id)
            print(company.seoUrl)
            var urlAddress = "https://moreoptom.ru/c/\(company.seoUrl)";
            if company.seoUrl == "" {
                urlAddress = "https://moreoptom.ru/company/get?id=\(company.id)"
            }
            if let url = URL(string: urlAddress) {
                UIApplication.shared.open(url)
            }
        }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
