import SwiftUI

struct SpecialGameView: View {
    @Binding var game: Game
    
    var body: some View {
        GroupBox {
            VStack {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: game.thumb) ?? URL(string: "https://loremflickr.com/640/360")!) { image in
                        image
                            .resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 100, height: 50)
                }
                Text("\(game.title)").bold().lineLimit(1)
                Text("Originally: \(game.normalPrice)$")
                Text("Discounted: \(game.salePrice)$").foregroundColor(.red)
                Text("Rating: \(game.steamRatingPercent)%")
//                Text(game.title).font(.custom("Futura-Medium", size: 22))
            }
        }
        .groupBoxStyle(ColoredGroupBox(color: .white))
        .shadow(radius: 5)
    }
}
