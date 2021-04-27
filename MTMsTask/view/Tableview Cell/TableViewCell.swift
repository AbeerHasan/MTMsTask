//
//  TableViewCell.swift
//  MTMsTask
//
//  Created by Boo Doo on 4/25/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var nameLable: UILabel!
    
    func configueCell(name: String){
        nameLable.text = name
    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
}
