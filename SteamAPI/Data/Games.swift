import Foundation

struct Game: Identifiable, Codable {
    let id = UUID()
    var title: String
    var normalPrice: String
    var salePrice: String
    var steamRatingPercent: String
    var thumb: String
}
