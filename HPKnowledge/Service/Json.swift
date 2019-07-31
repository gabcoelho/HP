//
//  Json.swift
//  MarvelKnowledge
//
//  Created by Gabriela Coelho on 10/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation

class Json {
    class func deserialize(data: Data) -> [String: Any]? {
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonDict as? [String: Any]
        } catch {
            return nil
        }
    }
    
    class func parseJsonResource(_ resource: String) ->  Data? {
            guard let path = Bundle(for: self).url(forResource: resource, withExtension: "json") else { return nil }
            do {
                let data = try Data(contentsOf: path)
                return data
            } catch let error {
                debugPrint(error.localizedDescription)
            }
            return nil
        }

}
