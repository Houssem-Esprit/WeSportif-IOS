

import UIKit
import ARSLineProgress
class LoginController: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    let homeSegueId = "home"
    let scanSegueId = "scan"
    let signUpSegueId = "new"
    let hud = ARSLineProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      

        
    }

    @IBAction func signInBtnClicked(_ sender: UIButton) {
        
        guard let email = userNameTF.text,!email.isEmpty else {
            showErrorEmailMSG()
            return  }
        guard let password = passwordTF.text, password.isValidPassword(),!password.isEmpty else {
            showErrorPasswordMSG()
            return }
        loginWithData(email: email, password: password)
        
        
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: signUpSegueId, sender: self)
    }
    
    
    
    public func showErrorEmailMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong userName", message: "Please fill with a valid userName", viewController: self)
    }
    public func showErrorPasswordMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong password", message: "your password must be at least 8 characters", viewController: self)
    }
    

    
    @IBAction func loginTouchIdClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: scanSegueId, sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == scanSegueId {
            if let scanVC = segue.destination as? TouchIdViewController {
                scanVC.touchDelegate = self
            }
        }
    }
    
    
    func redirectFromLoginToHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: self.homeSegueId, sender: self)
            
        }
    }
    
}

extension LoginController: TouchDelegate {
    func redirectToHome(isSuccess: Bool) {
        redirectFromLoginToHome()
    }
    
    
}
    
    


