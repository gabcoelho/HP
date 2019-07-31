//
//  SideMenu.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 16/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation

struct SideMenu {
    let title: String

    static func menuItems() -> [SideMenu] {
        return [SideMenu(title: "Characters"), SideMenu(title: "Spells")]
    }
}

