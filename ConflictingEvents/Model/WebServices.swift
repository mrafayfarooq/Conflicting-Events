//
//  WebServices.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/14/21.
//

import Foundation
class WebServices {
    static func loadData(completionHandler: @escaping ([Events]?, NetworkError?) -> Void) {
        guard let url = Bundle.main.url(forResource: "mock", withExtension: "json") else {
            return completionHandler(nil, .invalidPath)
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
            if statusCode != 200 {
                return completionHandler(nil, .requestResourceNotFound)
            }
            if let jsonData = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                    let value = try decoder.singleValueContainer().decode(String.self)
                  
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMMMM d, yyyy h:mm a"

                    if let date = formatter.date(from: value) {
                        return date
                    }
                    throw NetworkError.parsingError
                }
                do {
                    let events = try decoder.decode([Events].self, from: jsonData)
                    completionHandler(events, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .parsingError)
                }
            }
            completionHandler(nil,.parsingError)
        }
        
        dataTask.resume()
    }
}
