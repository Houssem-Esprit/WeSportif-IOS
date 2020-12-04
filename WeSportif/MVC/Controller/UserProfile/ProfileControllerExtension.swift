

import Foundation
import UIKit
import Kingfisher
extension ProfileController {
  
    
    
    func getUserProfileData() {
        guard let userConnected = (UserDefaults.standard.bool(forKey: "loggedIn") as? Bool) ,let login = (UserDefaults.standard.string(forKey: "login")) , let pass = (UserDefaults.standard.string(forKey: "password"))  else { return }


        ApiManager.shared.login(username: login, password: pass) { (userLogged) in
            debugPrint("userLogged", userLogged)
            
                DispatchQueue.main.async {
                    let baseImageUrlString: String = Route.imageUserFolder.description
                    let urlprofileImage = URL(string: "\(baseImageUrlString)\(userLogged?.user?.img  ?? "")") as? URL
                    self.imageUser.kf.setImage(with: urlprofileImage, placeholder: UIImage(named: "blankProfile"), options: nil, progressBlock: nil, completionHandler: nil)
                    
                    let baseImageUrlCoverString: String = Route.imageUserFolder.description
                    let urlcoverImage = URL(string: "\(baseImageUrlString)\((userLogged?.user?.coverImg)  ?? "")") as? URL
                    if  self.coverImage.kf.setImage(with: urlcoverImage) != nil{
                        debugPrint("image added")
                    }
                   self.emailUserLabel.text = (userLogged?.user?.email ?? "")
                    self.statusLabel.text = ( userLogged?.user?.role ?? 0 )  == 0 ? "User" : "Coach"
                    self.birthdayLabel.text = (userLogged?.user?.ddn?.GetFormatedDate() ?? "")
                    self.fullNameLabel.text = "\(userLogged?.user?.nom ?? "")  \(userLogged?.user?.prenom ?? "")"
                    self.phoneNumber.text = "\(userLogged?.user?.numTel ?? 0)"
                    var cinString = ""
                    if let cinChars: [Character] = Array((userLogged?.user?.cin) ?? "") {
                        for index in 0...cinChars.count - 1 {
                            if index < 5 {
                                cinString.append("*")
                            } else {
                                cinString.append(cinChars[index])
                            }
                        }
                        self.cinLabel.text = cinString
                        
                    }
                 
                }
            
            
        }
    }
}
