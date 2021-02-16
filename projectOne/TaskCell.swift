//
//  TaskCell.swift
//  projectOne
//
//  Created by Admin Mac on 12/02/21.
//

import UIKit




class TaskCell: UITableViewCell {

    @IBOutlet weak var taskname: UILabel!
    
    @IBOutlet weak var taskCheck: UIButton!
    
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
