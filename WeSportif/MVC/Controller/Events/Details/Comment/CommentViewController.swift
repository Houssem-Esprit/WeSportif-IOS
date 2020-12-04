

import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var commentTF: UITextView!
    @IBOutlet weak var commentBtn: UIButton!
    
    var event: Event? = nil {
        didSet {
            debugPrint(event, "this event")
            getEventComments(idEvent: event?.id ?? 0)
            DispatchQueue.main.async {
                self.eventName.text = self.event?.nom
                let baseImageUrlString: String = Route.imageEventFolder.description
                let url = URL(string: "\(baseImageUrlString)\(self.event?.img ?? "")") as? URL
                if let urlImage = url {
                    self.eventImage.kf.setImage(with: urlImage, placeholder: UIImage(named: "blankProfile"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            }
    }

    var commentsArray : [Reaction] = [] {
        didSet {
            self.commentTV.reloadData()
        }
    }
    @IBOutlet weak var commentTV: UITableView!
    let commentCellId = "commentaire"
    override func viewDidLoad() {
        super.viewDidLoad()
commentTV.delegate = self
        commentTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commentTV.rowHeight = UITableView.automaticDimension
        commentTV.estimatedRowHeight = 80
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    @IBAction func commentBtnClicked(_ sender: UIButton) {
        guard let text = commentTF.text, !text.isEmpty  else { return }
        ApiManager.shared.addComments(text: text, idEvent: event?.id ?? 0) { (stringResp) in
            self.getEventComments(idEvent: self.event?.id ?? 0)
           
            self.commentTF.text = "Your text here"
            self.view.endEditing(true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellId, for: indexPath) as? CommentFullCell
        let comment: Reaction = commentsArray[indexPath.row]
        let baseImageUrlString: String = Route.imageEventFolder.description
        let url = URL(string: "\(baseImageUrlString)\(comment.img ?? "")") as? URL
        if let urlImage = url {
            cell?.imageUser.kf.setImage(with: urlImage, placeholder: UIImage(named: "blankProfile"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        cell?.commentText.text = comment.userCOM ?? ""
        cell?.selectionStyle = .none
        return cell!
    }
    
    func getEventComments(idEvent: Int) {
        ApiManager.shared.getAllComments(idEvent: idEvent) { (comments) in
            debugPrint("comments", comments)
            if let commentsRes = comments?.reactions {
                self.commentsArray = commentsRes
            }
        }
    }
    
   

}
