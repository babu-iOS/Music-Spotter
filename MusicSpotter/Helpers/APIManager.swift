//
//  APIManager.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//



import Foundation
import Alamofire
import SwiftyJSON

typealias StatusServiceResponse = (Bool, String, JSON) -> Void
class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
     func makeRequest(url: String,completion: @escaping StatusServiceResponse) {
        
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let value):
                    
                    if let data = value {
                        let json = JSON(data)
                        
                        print("JSON Response:", json)
                        let message = json["message"].stringValue
                        let status = json["status"].intValue
                        
                        completion(true, message, json)
                    }
                case .failure(let error):
                    self.handleAPIError(error, completion: completion)
                }
            }
    }
    private func handleAPIError(_ error: Error, completion: @escaping StatusServiceResponse) {
        if let afError = error as? AFError {
            let errorMessage: String
            switch afError {
            case .responseValidationFailed(let reason):
                errorMessage = "Response validation failed: \(reason)"
            case .invalidURL(let url):
                errorMessage = "Invalid URL: \(url)"
            default:
                errorMessage = "Request failed: \(afError.localizedDescription)"
            }
            completion(false, errorMessage, JSON.null)
        } else {
            completion(false, error.localizedDescription, JSON.null)
        }
    }
}
