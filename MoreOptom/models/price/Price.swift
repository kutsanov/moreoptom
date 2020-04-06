//
//  PriceItem.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 21.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation

struct PriceItem: Codable {
    let id: Int
    let fishId: Int
    let typeId: Int
    let cityId: Int
    let name: String
    let costMin: Double?
    let oblast: String?
    let note: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fishId = "fish_id"
        case typeId = "type_id"
        case cityId = "city_id"
        case name
        case costMin = "cost_min"
        case oblast
        case note
        case photo
    }
}


struct Price: Codable {
    let tovars: [PriceItem]?
    
    enum CodingKeys: String, CodingKey {
        case tovars
    }
    
    init(){
        self.tovars = []
    }

    init(with tovars: [PriceItem]) {
        self.tovars = tovars
    }
    
    func fetchData(with page: Int, with complition: @escaping (Price) -> Void) {
        
        let url = "/price?page=\(page)"
           NetworkManager.shared.getData(from: url) { (data, response, error) in
               if let error = error { print(error); return }
               guard let data = data else { return }
            
               do {
                   let price = try JSONDecoder().decode(Price.self, from: data)
                   complition(price)
               } catch let jsonError {
                   print(jsonError)
               }
           }
           
       }
}
