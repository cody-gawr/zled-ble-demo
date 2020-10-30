//
//  Agent.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/12/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import Combine

struct Agent {
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared
        .dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
            .decode(type: T.self, decoder: decorder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum ZledAPI {
    static let base = URL(string: "http://hm10api.herokuapp.com/api/v2.0")!
}
