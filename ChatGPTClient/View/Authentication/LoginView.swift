import SwiftUI
struct ExampleView: View {
    
    @FetchRequest(fetchRequest: ConversationCore.fetchRequest(.all))
    private var conversations: FetchedResults<ConversationCore>
    @State private var selectedBook: ConversationCore?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(conversations, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    Text(book.name)
                }
            }
            .navigationSplitViewColumnWidth(200)
            .navigationTitle("Books")
            
        }  detail: {
            Text(selectedBook?.id.uuidString ?? "")
                .padding()
                .navigationTitle(selectedBook?.name ?? "")
        }
    }
}
