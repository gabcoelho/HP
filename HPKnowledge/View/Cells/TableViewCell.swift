//
//  GenericTableViewCell.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 15/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLabel(with text: String) {
        label.text = text
    }
    

}
