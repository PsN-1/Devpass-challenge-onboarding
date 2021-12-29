//
//  Networking.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 29/12/21.
//

import UIKit

class Networking {
    static func doGetReposFor(_ user: String, completionHandler: @escaping ((AnyObject) -> Void) ) {
        DispatchQueue.global().async {
            let urlPath = "https://api.github.com/users/\(user)/repos"
            if let url = URL(string: urlPath) {
                if let data = try? Data(contentsOf: url) {
                    let response = Networking.parse(json: data)
                    DispatchQueue.main.async {
                        completionHandler(response as AnyObject)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler([RepositoryModel]() as AnyObject)
                    }
                }
            }
        }
    }
    
    static func parse(json: Data) -> [RepositoryModel] {
        let decoder = JSONDecoder()
        do {
            let jsonData: [RepositoryModel] = try decoder.decode([RepositoryModel].self, from: json)
            
            print("Data Parsed: ")
            print(jsonData)
            return jsonData
        } catch {
            print("Error decoding Json")
            return [RepositoryModel]()
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
