//
//  APIEndPoints.swift
//
//

import UIKit
enum APIEndpoints {
    

    case getPictureList(Int,Int)
    
    func url()->String{
        switch self {
        case .getPictureList(let page, let limit):
             return pictureList("/v2/list", page: page,limit: limit)
       
        }
    }
}

extension APIEndpoints {
    
    
    fileprivate func apiBaseURL()->String{
       
        return "https://picsum.photos"
    }
    
    fileprivate func pictureList(_ path:String, page: Int, limit: Int)->String{
        
        let urlstring = "\(apiBaseURL())\(path)"
        
        guard let url = URL(string: urlstring) else{
            return urlstring
        }
        
        let signatureParams = ["page": String(page), "limit": String(limit)]
        let composedURL = APIManager.compose(url: url, params: signatureParams)
        
        if let finalstring =  composedURL?.absoluteString {
            return finalstring
        }
        
        return urlstring
    }
    
    
}

extension APIManager {
    
    static func compose(url:URL, params:[String:String])->URL?{
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems =  Array(components.queryItems ?? [])
        
        params.forEach { param in
             queryItems.append( URLQueryItem(name: param.key, value: param.value))
        }
        components.queryItems = queryItems
        
        return try? components.asURL()
        
    }
}
