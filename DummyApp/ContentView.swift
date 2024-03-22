import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        CategoriesOverviewView(viewModel: CategoriesOverviewViewModel())
    }
}

#Preview {
    ContentView()
}
