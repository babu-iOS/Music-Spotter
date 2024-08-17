//
//  SongListTableViewCell.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage :UIImageView! 
    @IBOutlet weak var forwardImage :UIImageView!
    @IBOutlet weak var songName :UILabel!
    @IBOutlet weak var authorName :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(icon:String,name:String,author:String){
        logoImage.loadImage(string: icon)
        songName.text = name
        authorName.text = author
    }
}
