//
//  DentalHygieneApi.swift
//  DentalHygieneReport
//
//  Created by Avinash Reddy on 3/1/20.
//  Copyright © 2020 Avinash Reddy. All rights reserved.
//

import Foundation

class DentalHygieneAPI {
    enum Endpoint {
        case moreDentalHygieneCollection(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .moreDentalHygieneCollection(let indexPageNumber):
                return "https://raw.githubusercontent.com/rune-labs/ios-code-challenge-areddy/master/api/\(indexPageNumber).json"
            }
        }
    }
    
    class func requestMoreDentalHygiene(indexPageNumber: String, completionHandler: @escaping ([DentalHygiene]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.moreDentalHygieneCollection(indexPageNumber).url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            
            let decoder = JSONDecoder()
            var dentalHygieneResponse = [DentalHygiene]()
            
            do {
                dentalHygieneResponse = try decoder.decode([DentalHygiene].self, from: data)
                completionHandler(dentalHygieneResponse, nil)
            } catch {
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
}
