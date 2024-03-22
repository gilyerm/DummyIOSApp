import SwiftUI

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)!, scale: 8)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("Price: \(String(format: "%.2f", product.price))")
                    .font(.subheadline)
                Text("Stock: \(product.stock)")
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProductRowView(product: CategoriesOverviewViewModel().categories[0].products[0])
}
