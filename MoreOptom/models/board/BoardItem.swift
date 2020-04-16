//
//  BoardItem.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 14.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation

struct BoardItemPhoto: Codable {
    let id: Int
    let url: String
    let urlSrc: String
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case urlSrc = "url_src"
    }
}

struct BoardItemImport: Codable {
    let item: BoardItem
}

struct BoardItem: Codable {
    var id: Int
    var firmId: Int
    var t: Int
    var title: String
    var txt: String
    var phone: String
    var mobile: String
    var photos: [BoardItemPhoto]
    var tName: String
    var firmNameShort: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firmId = "firm_id"
        case t
        case title
        case txt
        case phone
        case mobile
        case photos
        case tName = "t_name"
        case firmNameShort = "firm_name_short"
    }
    
    init() {
        self.id = 0
        self.firmId = 0
        self.t = 0
        self.title = ""
        self.txt = ""
        self.phone = ""
        self.mobile = ""
        self.photos = []
        self.tName = ""
        self.firmNameShort = ""
    }
    
    func fetchData(with id: Int, with complition: @escaping (BoardItem) -> Void) {
        let url = "/board/get?id=\(id)"
        NetworkManager.shared.getData(from: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            do {
                let item = try JSONDecoder().decode(BoardItemImport.self, from: data)
                complition(item.item)
            } catch let jsonError {
                print(jsonError)
                var tovar = Tovar()
                tovar.error = "Не удалось получить данные"
            }
        }
    }
    
}

