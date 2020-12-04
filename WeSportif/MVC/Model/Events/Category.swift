

import Foundation

// MARK: - Category
struct Category: Codable {
    let catInformations: String
    let cats: [Cat]
}

// MARK: - Cat
struct Cat: Codable {
    let idCat: Int
    let nom: String
}
