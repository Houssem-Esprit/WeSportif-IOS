
import Foundation

// MARK: - Comment
struct Comment: Codable {
    let reactionInformations: String?
    let reactions: [Reaction]?
}

// MARK: - Reaction
struct Reaction: Codable {
    let idReact: Int?
    let idUser: String?
    let idEvent: Int?
    let userCOM, cin, nom, prenom: String?
    let login, pass, email: String?
    let numTel: Int?
    let ddn, img, coverImg: String?
    let role: Int?
    
    enum CodingKeys: String, CodingKey {
        case idReact
        case idUser = "id_user"
        case idEvent = "id_event"
        case userCOM = "userCom"
        case cin, nom, prenom, login, pass, email, numTel, ddn, img, coverImg, role
}
}
