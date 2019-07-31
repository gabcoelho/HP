//
//  SideMenuViewModel.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 16/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SideMenuViewModel {
    
    private(set) var items = BehaviorRelay<[SideMenu]>(value: SideMenu.menuItems())
    
    func getMenuItens() -> [SideMenu] {
        return items.value
    }
    
    func menuItem(at indexPath: IndexPath) -> SideMenu {
        return items.value[indexPath.row]
    }
    
}
