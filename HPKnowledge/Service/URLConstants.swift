//
//  URLConstants.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 10/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation

struct URLConstants {
    static let apiScheme = "https:"
    static let apiHost = "//www.potterapi.com/v1/"
    static let apiKey = "?key=$2a$10$9.paasDbBktg5x2lYIYbN.YEXc.QB./uDuuPVewyDse3cS6Pu.RIi"
    
    static let characters = URLConstants.apiScheme + URLConstants.apiHost + "characters/" + URLConstants.apiKey
    static let spells = URLConstants.apiScheme + URLConstants.apiHost + "spells/" + URLConstants.apiKey
}
