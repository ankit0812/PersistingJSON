//
//  DataStore.swift
//  PersistingJSON
//
//  Created by KingpiN on 18/07/19.
//  Copyright © 2019 KingpiN. All rights reserved.
//

import Foundation
import CoreData

class DataStore: NSObject {
    
    let networking = NetworkingService.shared
    let persistenceService = PersistentService.shared
    
    private override init() {
        super.init()
    }
    
    static let shared = DataStore()

    func requestUsers(completion: @escaping ([User]) -> Void ) {
        networking.createRequest(urlPath: "https://www.kiloloco.com/api/users") { [weak self] (result) in
            switch result {
                //get some data
            case .success(let data):
                print(data)
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
                    print(jsonArray)
                    jsonArray.forEach {
                        guard let strongSelf = self,
                            let name = $0["name"] as? String,
                            let age = $0["age"] as? Int16,
                            let id = $0["id"] as? Int16
                            else { return }
                        let user = User.init(context: strongSelf.persistenceService.context)
                        user.name = name
                        user.age = age
                        user.id = id
                    }
                    //Save to core data
                    DispatchQueue.main.async {
                        self?.persistenceService.save {
                            self?.persistenceService.fetch(User.self, completion: { (users) in
                                completion(users)
                            })
                        }
                    }
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
