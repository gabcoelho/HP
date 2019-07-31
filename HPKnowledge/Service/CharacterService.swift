//
//  CharacterService.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxSwift

class CharacterService {
        
    func getCharactersList() -> Observable<[Characters]?> {
        guard let url = URL(string: URLConstants.characters) else {
            return Observable.just(nil)
        }
        let parameters = Data()
        let request = NetworkDispatcher.shared.createHTTPRequest(httpMethod: .get, url: url, parameters: parameters)
        return NetworkDispatcher.shared.responseArray(request)
    }
    
}
