

import UIKit

class CommentFullCell: UITableViewCell {

    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      imageUser.makeRounded()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
