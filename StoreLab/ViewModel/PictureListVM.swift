//
//  PictureListVM.swift
//  StoreLab
//
//  Created by tzh on 08/03/2023.
//

import Foundation
import RxSwift

class BaseViewModel: NSObject {
    var apiManager : APIManager = APIManager()
}
class PictureListVM: BaseViewModel {
    var pictures: PicListResponse?

    func getPictures(page: Int, limit: Int) -> Completable {
        
        return self.apiManager.getPictureList(endpointURL: .getPictureList(page,limit) )
            .flatMapCompletable { [weak self] (pictures) -> Completable in
              
                self?.pictures = pictures
                return Completable.empty()
        }
            .catchError({ error in
                return Completable.error(error)
            })
    }
    
}
