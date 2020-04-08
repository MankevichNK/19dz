//
//  NetworkManager.swift
//  20
//
//  Created by Alexander Golovashchenko on 3/20/20.
//  Copyright © 2020 Alexander Golovashchenko. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case defauldError
    
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func performRequst(_ request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    error == nil else {
                        completion(Result.failure(NetworkError.defauldError))
                        return
                }
                completion(Result.success(data))
            }
        }
        task.resume()
    }
    
    func loadCurrency(completion: @escaping (Result<CurrencyModel, Error>) -> Void) {
        let urlString = "http://data.fixer.io/api/latest?access_key=3eccb1ba66714102ba9a170f3c968db9"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
             
        performRequst(request) { result in
            switch result {
            case .success(let data):
                if let data = data,
                    let currencyModel = try? JSONDecoder().decode(CurrencyModel.self, from: data) {
                    completion(Result.success(currencyModel))
                } else {
                    completion(Result.failure(NetworkError.defauldError))
                }

            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
