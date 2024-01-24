import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("House Gurus")
                    .font(.system(size: 36, weight: .heavy, design:. rounded))
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
