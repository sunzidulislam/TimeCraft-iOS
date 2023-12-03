import SwiftUI
import CachedAsyncImage

struct NewsArticle: View {
    let title: String
    let imageURL: String
    let siteName: String
    let summary: String
    
    var body: some View {
        VStack {
            
            CardView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(siteName)
                        .foregroundColor(.blue)
                        .italic()
                        .padding(.horizontal, 14)
                    
                    CachedAsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .easeInOut)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .transition(.opacity)
                        } else {
                            // Placeholder image or view
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(height: 150)
                    .padding(.horizontal, 14)// Adjust the height as needed
                    
                    Text(title)
                        .font(.headline)
                        .padding(.horizontal, 14)
                        .padding(.bottom, 22)
                    
                    Text(summary)
                        .lineLimit(6)
                        .font(.body)
                        .padding(.horizontal, 8)
                }
            }
        }

    }
}

struct CardView<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 4)
    }
}

struct NewsArticle_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticle(title: "Title", imageURL: "testurl", siteName: "Code Palace", summary: "A free way to learn how to code.")
            .previewLayout(.sizeThatFits)
    }
}
