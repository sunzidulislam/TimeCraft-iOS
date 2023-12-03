import SwiftUI
import FirebaseDatabase
import Firebase

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel

    @State private var textFieldText: String = ""
    @State private var selectedDate = Date()
    @State private var descriptionText: String = ""
    @State private var showAlert: Bool = false
    private var alertTitle: String = "Your new todo item must be at least 3 characters long!"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Information")) {
                    TextField("Task Title", text: $textFieldText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    DatePicker("Due Date", selection: $selectedDate, in: Date()...)
                        .datePickerStyle(.compact)
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $descriptionText)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 1)
                        )
                        .padding(.vertical)
                }

                Section {
                    Button(action: saveButtonPressed) {
                        Text("SAVE")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .navigationTitle("Add Task")

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func saveButtonPressed() {
        if textIsAppropriate() {
            // Save data to Realtime Database
            let newItem = ItemModel(
                title: textFieldText,
                isComplated: false,
                dueDate: selectedDate,
                description: descriptionText
            )
            
            saveToDatabase(item: newItem)
            
            // Dismiss the view
            dismiss()
        }
    }

    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func saveToDatabase(item: ItemModel) {
    let ref = Database.database().reference().child("todos").childByAutoId()
        let itemData: [String: Any] = [
            "id": ref.key!,
            "title": item.title,
            "isCompleted": item.isCompleted,
            "dueDate": item.dueDate?.timeIntervalSince1970 ?? 2030, // Save timestamp for due date
            "description": item.description
        ]

        ref.setValue(itemData)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ListViewModel())
    }
}
