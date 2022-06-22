//
//  AirportTableViewCell.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var iata: UILabel!
    @IBOutlet weak var portImage: UIImageView!
    @IBOutlet weak var airportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
