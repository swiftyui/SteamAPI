import SwiftUI

struct SpecialsListView: View {
    @EnvironmentObject var steamGamesApi: SteamGamesAPI
    @State private var gridLayout: [GridItem] = [ GridItem(.adaptive(minimum: 100)), GridItem(.flexible()) ]
    @State var games = [Game]()
    @State var searchString = ""
    @State var isLoading = false
    
    var body: some View {
        

        NavigationStack {
            if self.isLoading {
                LottieView(lottieFile: "loading", loopMode: .loop)
            } else {
                GeometryReader { geo in
                    ScrollView {
                        SearchBar(searchString: $searchString)
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach($games.filter { self.searchString.isEmpty ? true : $0.title.wrappedValue.lowercased().contains(searchString.lowercased())}){ game in
                                SpecialGameView(game: game)
                                    .frame(width: geo.size.width / 2.2, height: 200)
                            }
                        }.padding(.all, 10)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Steam Sepcials").font(.custom("Futura-Medium", size: 22))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            self.isLoading = true
            steamGamesApi.loadData(url: "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=5") { games in
                self.games = games
                self.isLoading = false
            }
        }
    }
}
