

import UIKit

class UpdateProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // navBar buttons
//    lazy var saveBtn: UIBarButtonItem = {
//        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
//
//        return button
//    }()
//
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var cinTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    var isCover = false
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.makeRounded()
        //self.navigationController?.navigationItem.rightBarButtonItem = saveBtn
        self.title = "Update profile"
        self.emailTF.text = UserDefaults.standard.string(forKey: "email")
        self.phoneTF.text = UserDefaults.standard.string(forKey: "phone")
        self.cinTF.text = UserDefaults.standard.string(forKey: "cin")
        // Do any additional setup after loading the view.
    }
    
    
    public func showErrorEmailMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong userName", message: "Please fill with a valid userName", viewController: self)
    }
    public func showErrorPasswordMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong phone number", message: "your password must be at least 8 numbers", viewController: self)
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        guard let email = emailTF.text,!email.isEmpty else {
            showErrorEmailMSG()
            return  }
        guard let tel = phoneTF.text, tel.count < 9 && tel.count > 7,!tel.isEmpty else {
            showErrorPasswordMSG()
            return
    }
        guard let cin = phoneTF.text, tel.count == 8,!tel.isEmpty else {
            showErrorPasswordMSG()
            return
        }
        let paramsUser: [String: Any] = [
            "cin": cin,
            "email": email,
            "numTel": tel,
            "date_naissance": UserDefaults.standard.string(forKey: "birthday")
        ]
        ApiManager.shared.updateUser(cin: cin, email: email, tel: tel, birthday:UserDefaults.standard.string(forKey: "birthday")!) { (response) in
            if response != nil {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)

                }            }
        }
    }
    
//    @objc func save(sender: AnyObject) {
//          }

    @IBAction func changeCoverImageBtnClicked(_ sender: UIButton) {
        isCover = true
   openGallery()
  
    }
    /// picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if isCover {
            if let selectedImage: UIImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.coverImage.image = selectedImage
            }
        } else {
            if let selectedImage: UIImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.profileImage.image = selectedImage
            }
        }
        
                self.dismiss(animated: true, completion: nil)
    }

    @IBAction func changeProfileImgBtnClicked(_ sender: UIButton) {
        isCover = false
    openGallery()
        DispatchQueue.main.async {
            self.profileImage.makeRounded()
        }
     
    }
    
    
    func openGallery() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController,animated: true,completion: nil)
        if let image: UIImage = (isCover ? coverImage.image : profileImage.image) as? UIImage {
            ApiManager.shared.uploadImage(image: image, imageName: "imaaaaage") { (resp) in
                debugPrint(resp as! String)
            }
    }
    
}
}


// rounded imageview
extension UIImageView {
    
    func makeRounded() {
        
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
