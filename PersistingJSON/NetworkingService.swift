//
//  NetworkingService.swift
//  PersistingJSON
//
//  Created by KingpiN on 17/07/19.
//  Copyright © 2019 KingpiN. All rights reserved.
//

import UIKit

class NetworkingService {
    
    private init() {}
    static let shared = NetworkingService()

    func createRequest(urlPath: String, completion: @escaping(Result <Data, Error>) -> Void) {
        if let currentUrl = URL(string: urlPath) {
            let session = URLSession.shared
            let task = session.dataTask(with: currentUrl) { (data, _ , error) in
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                }
                if let unwrappedData = data {
                    completion(.success(unwrappedData))
                }
            }
            task.resume()
        } else {
            print("Something is wrong with the url")
        }
    }
}
