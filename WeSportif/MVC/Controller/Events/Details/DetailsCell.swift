

import UIKit

class DetailsCell: UITableViewCell {
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var coachName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
