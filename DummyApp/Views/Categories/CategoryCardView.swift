import SwiftUI

struct CategoryCardView: View {
    let category: Category

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: category.products[0].thumbnail)!, scale: 8)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))

            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                Text("Total Products: \(category.totalProducts)")
                    .font(.subheadline)
                Text("Total Stock: \(category.totalStock)")
                    .font(.subheadline)
                }
                .padding()
        }
    }
}
#Preview {
    CategoryCardView(category: CategoriesOverviewViewModel().categories[0])
}
