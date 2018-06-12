//
//  AuthorCell.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit

class AuthorCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
