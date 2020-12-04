
import UIKit
protocol CoachDelegate: class {
    func coachChoosen(coatch: User)
}
class CoachViewController: UIViewController {
    weak var coachDelegate: CoachDelegate?
    @IBOutlet weak var tableView: UITableView!
    var coatch: User?
    let cellIdentifier = "coach"
    var coachesArray: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }        }
    }
    @IBOutlet weak var coachesTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.shared.getAllCoachesWS { (coaches) in
            self.coachesArray = coaches?.users! ?? []
        }
    }
    
    @IBAction func returnBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CoachViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coachesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoachCell
        cell?.selectionStyle = .none
        let coach = coachesArray[indexPath.row]
        let baseImageUrlString: String = Route.imageUserFolder.description

        let url = URL(string: "\(baseImageUrlString)\(coach.img ?? "")") as? URL
        if let urlImage = url {
            cell?.userImg.kf.setImage(with: urlImage, placeholder: UIImage(named: "blankProfile"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        cell?.userNameLabel.text = (coach.nom ?? "") + (coach.prenom ?? "")
        
        return cell ?? UITableViewCell()
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.1

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coatch = coachesArray[indexPath.row]
        self.dismiss(animated: true) {
            if self.coatch != nil {
                self.coachDelegate?.coachChoosen(coatch: self.coatch!)
            }
        }
    }
    
}
