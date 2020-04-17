//
//  NetworkManager.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 05.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getData(from urlString: String, with complition: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlAddress = UtilsSettings.shared.apiUrl + urlString
        guard let url = URL(string: urlAddress) else { return }
        
        print(urlAddress)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(UtilsSettings.shared.apiKey, forHTTPHeaderField: "x-fawesome-token")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { return }
            guard let response = response else { return }
            
            complition(data, response, error)
        }.resume()
    }
    
    
    func getImage(from urlString: String, comletion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: urlString) else {
            let img = #imageLiteral(resourceName: "picture")
            comletion(img)
            return
        }
        
        
        if let cachedImage = getCachedImage(url: url) {
            comletion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            guard responseURL == url else { return }
            
            if let img = UIImage(data: data) {
                self.saveDataToCache(with: data, and: response)
                comletion(img)
            }
            
        }.resume()
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCache(with data: Data, and reponse: URLResponse) {
        guard let urlResponse = reponse.url else { return }
        let cachedResponse = CachedURLResponse(response: reponse, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
