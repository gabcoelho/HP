//
//  SpellService.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 15/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class SpellService {
    
    func getSpellsList() -> Observable<[Spell]?> {
        
        guard let url = URL(string: URLConstants.spells) else {
            return Observable.just(nil)
        }
        let parameters = Data()
        let request = NetworkDispatcher.shared.createHTTPRequest(httpMethod: .get, url: url, parameters: parameters)
        return NetworkDispatcher.shared.responseArray(request)
    }
}
