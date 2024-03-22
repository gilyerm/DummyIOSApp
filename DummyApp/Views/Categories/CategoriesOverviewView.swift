import SwiftUI

struct CategoriesOverviewView: View {
    @ObservedObject var viewModel: CategoriesOverviewViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if let error = viewModel.error {
                Text("There was an error. Try again. If the error persists, please contact support.\nError message:\(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                NavigationView {
                    List(viewModel.categories) { category in
                        NavigationLink(destination: CategoryDetailsView(category: category)) {
                            CategoryCardView(category: category)
                        }
                    }
                    .refreshable {
                        viewModel.fethDataFromAPI()
                    }
                    .navigationTitle("Categories")
                }
            }
        }
        .onAppear {
            viewModel.fethDataFromAPI()
        }
    }
}


#Preview {
    CategoriesOverviewView(viewModel: CategoriesOverviewViewModel())
}
