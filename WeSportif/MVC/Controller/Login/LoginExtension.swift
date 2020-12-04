

import Foundation
import UIKit
import ARSLineProgress
extension LoginController {
    
    func loginWithData(email: String, password: String) {
        // here we call login ws
        if ARSLineProgress.shown { return }

        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            print("Showed with completion block")
            UIApplication.shared.beginIgnoringInteractionEvents()
        }

        
        ApiManager.shared.login(username: email, password: password) { (userResponse) in

            if let response = userResponse {
                DispatchQueue.main.async{
                    ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                        ARSLineProgress.showSuccess()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        print("Hidden with completion block")
                    })
                }

               
                if let role: Int = response.user?.role, role == 0 {
                    UserDefaults.standard.set(false, forKey: "Coach")
                } else {
                    UserDefaults.standard.set(true, forKey: "Coach")
                }
                if let user = response.user, user != nil {
                     UserDefaults.standard.set(user.cin, forKey: "cin")
                    UserDefaults.standard.set(user.email, forKey: "email")
                    UserDefaults.standard.set(user.nom, forKey: "nom")
                    UserDefaults.standard.set(user.login, forKey: "login")
                    UserDefaults.standard.set(user.ddn!.GetFormatedDate(), forKey: "birthday")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(user.prenom, forKey: "lastName")
                    UserDefaults.standard.set(user.img, forKey: "image")
                    UserDefaults.standard.set(user.role, forKey: "role")
                    UserDefaults.standard.set(user.coverImg, forKey: "coverImage")
                    UserDefaults.standard.set(user.numTel, forKey: "phone")
                } else {
                    debugPrint("wrong data")
                    
                }
               debugPrint("wrong data")
                UserDefaults.standard.set(true, forKey: "loggedIn")
                self.redirectFromLoginToHome()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { () -> Void in
                    ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                        ARSLineProgress.showFail()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        print("Hidden with completion block")
                    })
                })


            }
        }
        
    }
    
}
