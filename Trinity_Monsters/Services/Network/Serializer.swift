//
//  Serializer.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 15.01.2021.
//

import Foundation

struct Serializer {
    
    static func decode<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let value = try decoder.decode(type, from: data)
            return value
        } catch let jsonError {
            print(jsonError.localizedDescription)
        }
        return nil
    }
}
