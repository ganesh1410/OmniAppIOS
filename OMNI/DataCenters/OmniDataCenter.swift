//
//  OmniDataCenter.swift
//  OMNI
//
//  Created by Chandrachudh on 06/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
import SwiftyJSON

enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}

typealias completionBlock = (Any?, Error?, String?) -> Void

private let timeOutInterval:Double = 30.0

class OmniDataCenter: NSObject {

    var domain: String = ""
    
    class var sharedInstance: OmniDataCenter {
        struct Static {
            static let instance: OmniDataCenter = OmniDataCenter()
        }
        return Static.instance
    }
    
    
    func sendRequest(connectingURL:String, httpMethod:HttpMethod, parameters:[String:Any]?, shouldShowLoadingIndicator:Bool, onCompletion:@escaping completionBlock) {
        
        let url = domain + connectingURL
        
        guard let URL = URL.init(string: url) else {
            fatalError("Some thing is wrong with the url: \(url)")
        }
        
        var request = getURLRequestWitPrefilledHeaders(connectingURL: URL)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if shouldShowLoadingIndicator {
            //show loading indicator
        }
        
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        request.httpMethod = httpMethod.rawValue
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOutInterval
        configuration.timeoutIntervalForResource = timeOutInterval
        
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if shouldShowLoadingIndicator {
                    //hide loading indicator
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if let data = data {
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {//SUCCESS SCENARIO
                        onCompletion(data, nil, nil)
                    } else {//FAILURE SCENARIO JSON PARSING
                        guard let error = error else {
                            onCompletion(nil, nil, "Something went wrong")
                            return
                        }
                        onCompletion(nil, error, "JSON Parsing error")
                    }
                }
                else {//FAILURE SCENARIO
                    onCompletion(nil, error, error?.localizedDescription)
                }
            }
            }.resume()
    }
}

extension OmniDataCenter {
    private func getURLRequestWitPrefilledHeaders(connectingURL:URL) -> URLRequest {
        var request = URLRequest.init(url: connectingURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
