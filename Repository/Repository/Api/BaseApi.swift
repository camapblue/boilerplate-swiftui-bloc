//
//  BaseApi.swift
//  Repository
//
//  Created by @camapblue on 1/8/22.
//

import Combine

typealias JsonResponse = Dictionary<String, Any>

public class BaseApi {
    let baseUrl: BaseUrl
    
    public init(_ baseUrl: BaseUrl) {
        self.baseUrl = baseUrl
    }
    
    func get(path: Endpoints) -> AnyPublisher<JsonResponse, Error> {
        let url = baseUrl.getUrl(of: path)
        
        return Future { [weak self] promise in
            guard self != nil else {
                promise(.success(JsonResponse()))
                return
            }
            let task = URLSession.shared
                .dataTask(with: url) { data, _, error in
                    if error == nil {
                        if let json = try! JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                            promise(.success(json))
                            return
                        }
                        promise(.success(JsonResponse()))
                    } else {
                        promise(.failure(error!))
                    }
                }
            task.resume()
        }
        .eraseToAnyPublisher()
    }
}
