
import Foundation
// MARK: - UserStats
struct UserStats: Codable {
    let userInformations: String?
    let user: User?
}
// MARK: - User
struct User: Codable {
    let cin, nom, prenom, login: String?
    let pass, email: String?
    let numTel: Int?
    let ddn, img: String?
    let role: Int?
    let coverImg: String?
}
