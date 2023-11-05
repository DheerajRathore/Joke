//
//  NetworkEngine.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 01/11/23.
//

import Foundation

/**
 This class is responsible for handling network request.
 */
class NetworkEngine {
    
    fileprivate var session: URLSession?
    
    /// Configure URL session
    var sessionConfig: URLSessionConfiguration
    
    init() {
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60
        sessionConfig.timeoutIntervalForResource = 60
        /// remove cache data.
        sessionConfig.urlCache = nil
    }
    
    /// Executes the web call and will decode the JSON response into the Codable object provided
    /// - Parameters:
    /// - urlRequest: the endpoint to make the HTTP request against
    /// - completion: the JSON response converted to the provided Codable object, if successful, or failure otherwise
    func request(urlRequest: URLRequest, completionHandler: @escaping (Data?, HTTPURLResponse?, APIError?) -> Void) {
        requestData(urlRequest: urlRequest) { responseData, httpResponse, error  in
            completionHandler(responseData, httpResponse, error)
        }
    }
    
    private func requestData(urlRequest: URLRequest, completionHandler: @escaping (Data?, HTTPURLResponse?, APIError?) -> Void) {
        
        self.session = URLSession(configuration: self.sessionConfig, delegate: nil, delegateQueue: nil)
        
        let dataTask = self.session?.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(nil, response as? HTTPURLResponse, APIError.requestFailed(description: error.localizedDescription))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, nil, APIError.requestFailed(description: "Request Failed"))
                    return
                }
//
//                let str = String(decoding: data!, as: UTF8.self)
//                print("request url => \(urlRequest.url)")
//                print("HttpStatusCode => \(response.statusCode)")
//                print(str)
//
                completionHandler(data, response, nil)
            }
            
        }
        dataTask?.resume()
    }
}


