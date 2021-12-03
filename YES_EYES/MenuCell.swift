//
//  MenuCell.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/24.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        menuTitle.textColor = .black
        menuTitle.font = UIFont(name: "NanumSquareOTFB", size: 30)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
