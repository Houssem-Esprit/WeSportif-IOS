
import UIKit

class SignUpSecondController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cinTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var surNameTF: UITextField!
    @IBOutlet weak var addFileBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    var coachSelected: Bool = false
    var isCoach: Bool = true {
        didSet {
           self.addFileBtn.isHidden = !isCoach
        }
        
    }
    var username = ""
    var  fileAdded: Bool = false
    var email = ""
    var password = ""
    var role = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        isCoach = false
// self.addFileBtn.isHidden = !isCoach
//        if isCoach {
//             self.signUpBtn.isEnabled = fileAdded
//            self.signUpBtn.backgroundColor = fileAdded ? UIColor.white : UIColor.lightGray
//        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        guard let name = nameTF.text, name.isValidName(),!name.isEmpty else {
          showErrorUserNameMSG()
            return }
        guard let surName = surNameTF.text, surName.isValidName(),!surName.isEmpty else {
           
            showErrorUserNameMSG()
            return }
        guard let phone = phoneNumberTF.text, phone.count > 7,!phone.isEmpty else {
          showErrorUserNameMSG()
            return }
        guard let birthday = birthdayTF.text, !birthday.isEmpty else {
            showErrorUserNameMSG()
            return }
        guard let cin = cinTF.text, cin.count == 8,!cin.isEmpty else {
            showErrorUserNameMSG()
            return }
        let parametres: [String: Any] = ["cin": cin,
                          "nom": surName,
                          "prenom": name,
                          "login": username,
                          "pass": password,
                          "email": email,
                          "numTel": phone,
                          "date_naissance": birthday,
                          "img": "img.jpg",
                          "role": role,
                          "cat": "[{'idCat': 1},{'idCat':2}]"]
        self.signUpUser(userDict: parametres)
    }
    
    public func showErrorUserNameMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong data", message: "Please fill with a valid data", viewController: self)
    }
    
    public func showSuccessSignUpMSG() {
        AlertPopUp().showValidationAlert(title: "successfuly added", msg: "this user is added", viewController: self) {
            self.dismiss(animated: true, completion: nil)
        }    }
    public func showErrorSignUpMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "unable to save", message: "please check your connectivity", viewController: self)
    }
    @IBAction func backToLoginClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
    func signUpUser(userDict: [String: Any])  {
        ApiManager.shared.signUpUser(userParams: userDict) { (respString) in
            if respString == "User added" {
                self.showSuccessSignUpMSG()
            } else {
                self.showErrorSignUpMSG()
            }
        }
        
    }
    
    
    @IBAction func addFileBtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "addFile", sender: self)
    }
    
    

}
