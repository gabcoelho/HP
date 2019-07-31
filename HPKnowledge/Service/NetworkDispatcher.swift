//
//  NetworkDispatcher.swift
//  MarvelKnowledge
//
//  Created by Gabriela Coelho on 10/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxSwift


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkDispatcher {
    
    static let shared = NetworkDispatcher()
    
    func createHTTPRequest(httpMethod: HTTPMethod, url: URL, parameters: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let parameters = parameters {
            request.httpBody = parameters
            _ = Json.deserialize(data: parameters)
        }
        return request
    }
    
    // MARK: - Dispatch Request
    internal func dispatch(_ urlRequest: URLRequest, completionHandler: @escaping (_ data: Data?, _ errorService: ServiceResponse) -> Void) -> Void {
        let request = urlRequest
        let task = URLSession.shared.dataTask(with: request) {
            data, res, error in
            guard(error == nil) else {
                completionHandler(nil, ServiceResponse.failure)
                return
            }
            guard let data = data else {
                completionHandler(nil, ServiceResponse.decodingError)
                return
            }
            completionHandler(data, ServiceResponse.success)
        }
        task.resume()
    }
    
//    // MARK: - Dispatch T type json
//    func response<T: Codable>(_ urlRequest: URLRequest) -> Observable<T?> {
//        return Observable<T?>.create({ (observer) -> Disposable in
//        
//            self.dispatch(urlRequest) {
//                data, error in
//                if let data = data  {
//                    do {
//                        let rawResponse = String(data: data, encoding: .utf8)
//                        print(rawResponse ?? "no rawResponse")
//                        let resultObject = try JSONDecoder().decode(T.self, from: data)
//                        observer.onNext(resultObject)
//                    } catch let error {
//                        observer.onError(error)
//                    }
//                    observer.onCompleted()
//                }
//            }
//            return Disposables.create()
//        })
//    }

    // MARK: - Service for array
    func responseArray<T:Codable>(_ urlRequest: URLRequest) -> Observable<[T]?> {
        return Observable<[T]?>.create({ (observer) -> Disposable in
            
            self.dispatch(urlRequest, completionHandler: { (data, error) in
                if let data = data {
                    do {
                        let resultObject = try JSONDecoder().decode([T].self, from: data)
                        observer.onNext(resultObject)
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        })
    }
    
    func quizData() -> Observable<[Quiz]?> {
        return Observable<[Quiz]?>.create({ (observer) -> Disposable in
            if let data = Json.parseJsonResource("harrypotter") {
                do {
                    let result = try JSONDecoder().decode([Quiz].self, from: data)
                    observer.onNext(result)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }

    
}



