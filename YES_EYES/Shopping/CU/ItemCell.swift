//
//  ItemCell.swift
//  YES_EYES
//
//  Created by Moon on 2021/08/02.
//

import UIKit
protocol CartDelegate {
    func updateCart(cell: ItemCell)
}
class ItemCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var delegate: CartDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addButton.layer.cornerRadius = 5
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(didTabAddButton), for: .touchUpInside)
        
        
    }
    func setButton(state: Bool) {
        addButton.isSelected = state
        addButton.backgroundColor = (!addButton.isSelected) ? .black : .red
    }
    
    @objc func didTabAddButton() {
        setButton(state: !addButton.isSelected)
        self.delegate?.updateCart(cell: self)
    }
    
}
