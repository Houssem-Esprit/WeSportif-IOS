

import UIKit

class ProfileController: BaseViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cinLabel: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.setUpClassName(className: "Profile")
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7
    

        // Do any additional setup after loading the view.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserProfileData()
    }
    @IBAction func UpdatePrifileClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "update", sender: self)
    }
   

}
