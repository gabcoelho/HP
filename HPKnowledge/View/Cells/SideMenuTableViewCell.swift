//
//  SideMenuTableViewCell.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 16/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureSideMenuCell(with item: SideMenu) {
        label.text = item.title
    }

}
