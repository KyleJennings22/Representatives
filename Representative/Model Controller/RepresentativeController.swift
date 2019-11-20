//
//  RepresentativeController.swift
//  Representative
//
//  Created by Kyle Jennings on 11/20/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation

class RepresentativeController {
    //static let sharedInstance = RepresentativeController()
    
    var reps: [Representative] = []
    
    
    
    static func searchRepresentatives(forState state: String, completion: @escaping ([Representative]) -> Void) {
        let baseURL = URL(string: "http://whoismyrepresentative.com/getall_reps_bystate.php")
        guard let theURL = baseURL else {return completion([])}
        let urlParameters = ["state": "\(state)", "output": "json"]
        let queryItems = urlParameters.compactMap( { URLQueryItem(name: $0.key, value: $0.value)})
        var urlComponents = URLComponents(url: theURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {return completion([])}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion([])
            }
            guard let data = data else {
                return completion([])
            }
            
            guard let dataAsAscii = String(data: data, encoding: .ascii) else {return completion([])}
            guard let newData = dataAsAscii.data(using: .utf8) else {return completion([])}
            
            do {
                let jsonDictionary = try JSONDecoder().decode([String: [Representative]].self, from: newData)
                print(jsonDictionary)
                guard let representatives = jsonDictionary["results"] else {return completion([])}
                completion(representatives)
            } catch {
                print(error)
                return completion([])
            }
        }
        dataTask.resume()
    }
}
