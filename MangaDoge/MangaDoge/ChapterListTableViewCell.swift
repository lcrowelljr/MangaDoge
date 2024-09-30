//
//  ChapterListTableViewCell.swift
//  MangaDoge
//
//  Created by Lani Crowell on 9/29/24.
//

import UIKit

class ChapterListTableViewCell: UITableViewCell {

    @IBOutlet weak var chapterName: UILabel!
    @IBOutlet weak var chapterNum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
