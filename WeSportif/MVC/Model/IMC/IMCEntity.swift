

import Foundation

// MARK: - Imc
// MARK: - Imc
struct Imc: Codable {
    let userInformations: String?
    let imcs: [ImcElement]?
}

// MARK: - ImcElement
struct ImcElement: Codable {
    let id, poids, hauteur: Int?
    let valeurImc: Double?
    let idUser: String?
    
    enum CodingKeys: String, CodingKey {
        case id, poids, hauteur
        case valeurImc = "valeur_imc"
        case idUser = "id_user"
    }
}
