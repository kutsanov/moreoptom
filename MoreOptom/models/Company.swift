//
//  Company.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 16.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation

struct CompanyItem: Codable {
    let id: Int
    let name: String
    let seoUrl: String
    let cityName: String
    let regionName: String
    let phone: String
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case seoUrl = "seo_url"
        case cityName = "city_name"
        case regionName = "region_name"
        case phone
        case error
    }
    
    init(){
        self.id = 0
        self.name = ""
        self.seoUrl = ""
        self.cityName = ""
        self.regionName = ""
        self.phone = ""
        self.error = ""
    }
}

struct Company: Codable {
    let models: [CompanyItem]?
    
    enum CodingKeys: String, CodingKey {
        case models
    }
    
    init(){
        self.models = []
    }
    
    init(with company: [CompanyItem]) {
        self.models = company
    }
    
    func fetchData(with page: Int, with fnd: String, with complition: @escaping ([CompanyItem]) -> Void) {
        
        let oblastId = UtilsSettings.shared.getOblastId()
        
        let p = page - 1

        let url = "/company/search?page=\(p)&fnd=\(fnd)&region_id=\(oblastId)"
        NetworkManager.shared.getData(from: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            do {
                let companys = try JSONDecoder().decode(Company.self, from: data)
                complition(companys.models ?? [])
            } catch let jsonError {
                print(jsonError)
                var company = CompanyItem()
                company.error = "Не удалось получить данные"
                complition([company])
            }
        }
    }
    
}
