//
//  JokeListService.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 31/10/23.
//

import Foundation

final class JokeListService: NetworkEngine {
    
    private func getRequest() -> URLRequest{
        let urlString =  BaseURL.apiBaseUrl + EndPoint.getJoke
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
    
    /// call API to force verify sms string.
    func getJokesFromServer(completion:  @escaping (Data?, HTTPURLResponse?, APIError?) -> Void) {
        let generateSMSRequest = getRequest()
        self.request(urlRequest: generateSMSRequest) { data, response, error in
            completion(data, response, error)
        }
    }
}
