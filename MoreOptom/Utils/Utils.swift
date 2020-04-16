//
//  Utils.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 05.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation
import UIKit

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
    
    func resizeImage(height heightImage: CGFloat, image: UIImage) -> UIImage {
      let size = image.size
        let scale = Double(size.width / size.height)
        let height = Double(heightImage)
        let width = height * scale
        
      let newSize = CGSize(width: width,  height: height)
      let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      image.draw(in: rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage!
    }
}
