import SwiftUI

struct CategoryDetailsView: View {
    let category: Category
    
    var body: some View {
        VStack {
            List(self.category.products, id: \.id) { product in
                ProductRowView(product: product)
            }
            .navigationTitle(category.name)
        }
    }

}

#Preview {
    CategoryDetailsView(category: CategoriesOverviewViewModel().categories[0])
}
