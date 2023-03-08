//
//  APIManager.swift
//
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

typealias APIManagerClosure<K> = (K?)->Void

class APIManager: NSObject {

    func getPictureList(endpointURL: APIEndpoints) -> Single<PicListResponse> {
      
        return Single<PicListResponse>.create(subscribe: { (observer) -> Disposable in
           
            AF.request(endpointURL.url(), method: .get, parameters: nil,  headers: nil)
            .responseDecodable(of: PicListResponse.self){response in
                if let model = response.value  {
                    observer(.success(model))
                }
                else {
                   
                    if let error = response.error {
                        
                        observer(.error(error))
                        return
                    }
                }
            }
            
            
            return Disposables.create {
                return
            }
        })
       
    }
    
}
