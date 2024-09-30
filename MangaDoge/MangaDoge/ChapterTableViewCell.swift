//
//  ChapterTableViewCell.swift
//  MangaDoge
//
//  Created by Lani Crowell on 9/13/24.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mangaNameLabel: UILabel!
    @IBOutlet weak var uploaderNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
