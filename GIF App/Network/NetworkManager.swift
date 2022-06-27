//
//  NetworkManager.swift


import Alamofire
import Foundation
import Combine
import SwiftyJSON

class NetworkManager: NSObject {
    
    static var shared = NetworkManager()
    // API key
    private let api_key = "URCj9expuT1Wf6Eq8MMkXYurylrKWu5U"
    // Base URL 
    private let api_url_base = "https://api.giphy.com/v1/gifs/trending?offset=0&limit=10&api_key="

    
    func getAllGIFList(completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void) {
        let requestURL = api_url_base + api_key
        print(requestURL)
        AF.request(requestURL, method: .get,  parameters:nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let value ):
                    let responseDict = JSON(value)
                    completion(responseDict, nil)
                    
                case .failure(let error):
                    print("status error : ",error)
                   
                }
            }
    }
    
}
