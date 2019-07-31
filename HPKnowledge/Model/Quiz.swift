//
//  Quiz.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation


struct Quiz: Codable {
    var question: String
    var options: [String]
    var rightAnswer: String
    var imagem: String
}
