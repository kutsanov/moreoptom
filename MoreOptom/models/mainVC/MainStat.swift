//
//  MainStat.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 01.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation

struct MainStatTovar: Codable {
    let fishId: Int
    let fishName: String
    let cnt: Int
    let costAvg: Float
    let costMin: Float
    let costMax: Float
    let photo: String
    enum CodingKeys: String, CodingKey {
        case fishId = "fish_id"
        case fishName = "fish_name"
        case cnt
        case costAvg = "cost_avg"
        case costMin = "cost_min"
        case costMax = "cost_max"
        case photo
    }
    
}

struct MainStat: Codable {
    let firmCnt: Int
    let tovarCnt: Int
    let tovars: [MainStatTovar]
    
    enum CodingKeys: String, CodingKey {
        case firmCnt = "firm_cnt"
        case tovarCnt = "tovar_cnt"
        case tovars
    }
    
    init(){
        self.firmCnt = 0
        self.tovarCnt = 0
        self.tovars = []
    }
    
    init(with firmCnt: Int, with tovarCnt: Int, with tovars: [MainStatTovar]) {
        self.firmCnt = firmCnt
        self.tovarCnt = tovarCnt
        self.tovars = tovars
    }
    
    func fetchData(with complition: @escaping (MainStat) -> Void) {
        
        NetworkManager.shared.getData(from: "/stat/main") { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            do {
                let mainStat = try JSONDecoder().decode(MainStat.self, from: data)
                complition(mainStat)
            } catch let jsonError {
                print(jsonError)
            }
        }
        
    }
}
