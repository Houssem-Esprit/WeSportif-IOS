

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var statusSegmented: UISegmentedControl!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    
    var isCoachSelected: Bool = false
    let secondSegueId = "second"
    var valueStatus: String = ""
    var segmentedIndex: Int = 0 {
        didSet {
            if segmentedIndex == 0 {
                self.valueStatus = "SprotsMan"
                self.isCoachSelected = false
            } else {
                self.valueStatus = "Coach"
                self.isCoachSelected = true
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedIndex = statusSegmented.selectedSegmentIndex
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func statusChanged(_ sender: UISegmentedControl) {
        segmentedIndex = sender.selectedSegmentIndex
        
    }
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        debugPrint(valueStatus)
        guard let userName = userNameTF.text, userName.isValidName(),!userName.isEmpty else {
            showErrorUserNameMSG()
            return }
        guard let email = emailTF.text, email.isValidEmail(),!email.isEmpty else {
            showErrorEmailMSG()
            return }
        guard let password = passwordTF.text, password.isValidPassword(),!password.isEmpty else {
            showErrorPasswordMSG()
            return }
        guard let confirmPassword = confirmPasswordTF.text, confirmPassword == password,!confirmPassword.isEmpty else {
            showErrorConfirmPasswordMSG()
            return }
        performSegue(withIdentifier: secondSegueId, sender: self)
        
        
    }
    @IBAction func backToLoginBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == secondSegueId {
            if let nextVC = segue.destination as? SignUpSecondController {
                nextVC.email = emailTF.text ?? ""
                nextVC.username = userNameTF.text ?? ""
                nextVC.password = passwordTF.text ?? ""
                nextVC.role = self.segmentedIndex
                nextVC.coachSelected = isCoachSelected
            }
        }
    }
    
    
    
}
