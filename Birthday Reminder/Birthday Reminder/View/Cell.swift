//
//  Cell.swift
//  new app
//
//  Created by Vitaliy Shmelev on 24.05.2022.
//

import UIKit

class Cell: UITableViewCell {
    static let indentifire = "Cell"
    static func nib() -> UINib {
        return UINib(nibName: "Cell", bundle: nil)
    }
    @IBOutlet weak var dateBirthday: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var currentDay: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageInCell.contentMode = .scaleAspectFill
        imageInCell.makeRounded()

    }
        
    public func configureCell(nameLB: String, image: UIImage, birthday: String, days: Int) {
        nameLabel.text = nameLB
        imageInCell.image = image
        dateBirthday.text = birthday
        currentDay.text = "через \(days) дней"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
