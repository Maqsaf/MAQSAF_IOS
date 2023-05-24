
import SwiftUI

public struct NCGRScrollView<Content: View>: View {
    var content: Content
    var onRefresh: () -> Void

    public init(content: @escaping () -> Content, onRefresh: @escaping () -> Void) {
        self.content = content()
        self.onRefresh = onRefresh
    }

    public var body: some View {
        if #available(iOS 16.0, *) {
            ScrollView (showsIndicators: false) {
                content
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                   // .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }.refreshable {
                onRefresh()
            }
            .padding()

        } else {
            List {
                content
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                   // .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            .refreshable {
                onRefresh()
            }
        }
    }
}
