//
//  Tovar.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 09.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation
//import UIKit

struct Image: Codable {
    let id: Int
    let url: String
    let urlSm: String
    let urlMd: String

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case urlSm = "url_sm"
        case urlMd = "url_md"
    }
}

struct TovarImport: Codable {
    let tovar: Tovar
}

struct Tovar: Codable {
    var id: Int
    var firmId: Int
    var typeId: Int
    var fishId: Int
    var cityId: Int
    var name: String
    var cost1Unit: String
    var cost1Note: String
    var cost1: Float
    var cost2Unit: String
    var cost2Note: String
    var cost2: Float
    var cost3Unit: String
    var cost3Note: String
    var cost3: Float
    var size: String
    var producer: String
    var dtTovar: String
    var note: String
    var packWeight: String
    var regionId: Int
    var cityName: String
    var regionName: String
    var firmName: String
    var firmPhone: String
    var mobile: String
    var libTypeProductName: String
    var libFishName: String
    var images: [Image]
    var error: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firmId = "firm_id"
        case typeId = "type_id"
        case fishId = "fish_id"
        case cityId = "city_id"
        case name
        case cost1Unit = "cost_1_unit"
        case cost1Note = "cost_1_note"
        case cost1 = "cost_1"
        case cost2Unit = "cost_2_unit"
        case cost2Note = "cost_2_note"
        case cost2 = "cost_2"
        case cost3Unit = "cost_3_unit"
        case cost3Note = "cost_3_note"
        case cost3 = "cost_3"
        case size
        case producer
        case dtTovar = "dt_tovar"
        case note
        case packWeight = "pack_weight"
        case regionId = "region_id"
        case cityName = "city_name"
        case regionName = "region_name"
        case firmName = "firm_name"
        case firmPhone = "firm_phone"
        case mobile
        case libTypeProductName = "lib_type_product_name"
        case libFishName = "lib_fish_name"
        case images
        case error
    }
    
    init(){
        
        self.id = 0
        self.firmId = 0
        self.typeId = 0
        self.fishId = 0
        self.cityId = 0
        self.name = ""
        self.cost1Unit = ""
        self.cost1Note = ""
        self.cost1 = 0.0
        self.cost2Unit = ""
        self.cost2Note = ""
        self.cost2 = 0.0
        self.cost3Unit = ""
        self.cost3Note = ""
        self.cost3 = 0.0
        self.size = ""
        self.producer = ""
        self.dtTovar = ""
        self.note = ""
        self.packWeight = ""
        self.regionId = 0
        self.cityName = ""
        self.regionName = ""
        self.firmName = ""
        self.firmPhone = ""
        self.mobile = ""
        self.libTypeProductName = ""
        self.libFishName = ""
        self.images = []
        self.error = nil
    }
    
    
    func fetchData(with id: Int, with complition: @escaping (Tovar) -> Void) {
        
        
        let url = "/price/get?id=\(id)"
        NetworkManager.shared.getData(from: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            do {
                let tovar = try JSONDecoder().decode(TovarImport.self, from: data)
                complition(tovar.tovar)
            } catch let jsonError {
                print(jsonError)
                var tovar = Tovar()
                tovar.error = "Не удалось получить данные"
                complition(tovar)
            }
        }
    }

}

