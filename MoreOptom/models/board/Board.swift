//
//  Board.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 13.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation


struct BoardProviderItem: Codable {
    
    let id: Int
    let t: Int
    let tName: String
    let title: String
    let txt: String
    let txtShort: String?
    let firmName: String
    let phone: String
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case t
        case tName = "t_name"
        case title
        case txt
        case txtShort = "txt_short"
        case firmName = "firm_name"
        case phone
        case photo
    }
}

struct BoardProvider: Codable {
    let tovars: [BoardProviderItem]
    
    init(){
        self.tovars = []
    }
    
    init(with tovars: [BoardProviderItem]) {
        self.tovars = tovars
    }
    
    func fetchData(with page: Int, with complition: @escaping (BoardProvider) -> Void) {
        
        let oblastId = UtilsSettings.shared.getOblastId()
        let t = UtilsSettings.shared.getBoardTypeId()
        
        let p = page - 1
        
        let url = "/board?page=\(p)&region_id=\(oblastId)&t=\(t)"
        NetworkManager.shared.getData(from: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let tovars = try JSONDecoder().decode(BoardProvider.self, from: data)
                complition(tovars)
            } catch let jsonError {
                print(jsonError)
            }
        }
    }
    
}
