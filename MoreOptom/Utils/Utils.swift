//
//  Utils.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 05.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation


class Utils {
    static let shared = Utils()
    
    private init() {}
    
    func separatedNumber(_ number: Any) -> String {
        guard let itIsANumber = number as? NSNumber else { return "Not a number" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        return formatter.string(from: itIsANumber)!
    }
}
