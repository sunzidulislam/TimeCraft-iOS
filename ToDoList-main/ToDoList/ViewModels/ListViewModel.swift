import Foundation
import FirebaseDatabase
import Firebase

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }

    private let itemsKey = "items_list"
    private let databaseRef = Database.database().reference().child("todos")

    init() {
        getItemsFromDatabase()
    }

    // Fetches data from Firebase Realtime Database and assigns it to the 'items' array.
    func getItemsFromDatabase() {
        databaseRef.observe(.value) { snapshot in
            guard let data = snapshot.value as? [String: Any] else {
                return
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: Array(data.values), options: [])
                let decodedItems = try JSONDecoder().decode([ItemModel].self, from: jsonData)
                self.items = decodedItems
            } catch {
                print("Error decoding items: \(error)")
            }
        }
    }
    
    func deleteItem(index: IndexSet) {
         items.remove(atOffsets: index) // Perform item deletion at the specified index.
     }

       
       func moveItem(from: IndexSet, to: Int) {
           items.move(fromOffsets: from, toOffset: to) // Perform item moving from one index to another.
       }
       
       func addItem(title: String) {
           let newItem = ItemModel(title: title, isComplated: false, description: "") // Fixed the issue with 'isComplated' and 'description'.
           items.append(newItem)
       }
       
       func updateItem(item: ItemModel) {
           if let index = items.firstIndex(where: { $0.id == item.id }) {
               items[index] = item.updateCompletion()
           }
       }
       
       // Saves the 'items' array to UserDefaults.
       func saveItems() {
           if let encodeData = try? JSONEncoder().encode(items) {
               UserDefaults.standard.setValue(encodeData, forKey: itemsKey)
           }
       }
    func deleteItem(item: ItemModel) {
           if let index = items.firstIndex(where: { $0.id == item.id }) {
               items.remove(at: index)
               saveItems() // Save the updated list locally
               
               // Delete from Firebase
               deleteFromDatabase(item: item)
           }
       }

       // Function to delete item from Firebase
       func deleteFromDatabase(item: ItemModel) {
           let ref = Database.database().reference().child("todos").child(item.id)
           ref.removeValue()
       }
   }

    // Other functions (deleteItem, moveItem, addItem, updateItem, saveItems) remain the same.

