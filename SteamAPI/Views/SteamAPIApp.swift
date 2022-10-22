import SwiftUI

@main
struct SteamAPIApp: App {
    @StateObject var steamGamesApi: SteamGamesAPI = SteamGamesAPI()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining: Int = 3
    @State var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if self.isLoading {
                SplashScreenView().onReceive(timer) {_ in
                    if ( timeRemaining > 0 )
                    {
                        timeRemaining -= 1
                    }
                    if (timeRemaining <= 0)
                    {
                        timer.upstream.connect().cancel()
                        isLoading = false
                    }
                }
            } else {
                TabView {
                    SpecialsListView().environmentObject(steamGamesApi).tabItem() {
                        Label("Specials", systemImage: "opticaldisc")
                    }
                }
            }
        }
    }
}
