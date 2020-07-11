//
//  JSONDecoder-Remote.swift
//  FriendFace
//
//  Created by Oliver Lippold on 11/07/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromUrl url: String, completion: @escaping(T) -> Void) {
    guard let url = URL(string: url) else {
        fatalError("Invalid URL passed")
    }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let downloadedFriends = try self.decode(type, from: data)
                
                DispatchQueue.main.async {
                    completion(downloadedFriends)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
