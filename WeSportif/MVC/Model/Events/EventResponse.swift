

import Foundation
import Foundation

// MARK: - Events
struct EventResponse: Codable {
    let eventInformations: String
    let events: [Event]?
}

// MARK: - Event
struct Event: Codable {
    let id: Int
    let titre, eventDescription, img, dateDebut: String
    let dateFin, heureDebut, heureFin, lieu: String
    let lng, lat: String
    let capacite: Int
    var coach: String? = nil
    let eventUserAdmin: String
    let eventIDCat, idCat: Int
    let nom: String
    
    enum CodingKeys: String, CodingKey {
        case id, titre
        case eventDescription = "description"
        case img
        case dateDebut = "date_debut"
        case dateFin = "date_fin"
        case heureDebut = "heure_debut"
        case heureFin = "heure_fin"
        case lieu, lng, lat, capacite, coach
        case eventUserAdmin = "event_user_admin"
        case eventIDCat = "id_cat"
        case idCat, nom
    }
}

