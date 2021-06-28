//
//  PersonsTableViewCell.swift
//  cl3_quiroz
//
//  Created by DARK NOISE on 25/06/21.
//

import UIKit

class PersonsTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreTableCell: UILabel!    
    @IBOutlet weak var emailTableCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
