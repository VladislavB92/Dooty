//
//  AddView.swift
//  Dooty
//
//  Created by Vladislavs Buzinskis on 24/07/2022.
//

import SwiftUI

struct AddView: View {
    
    enum Field: Hashable {
            case toDoTask
        }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Returns back to list when saving the task
    @Environment(\.presentationMode) var presentationMode
    
    
    @State var toDoTask: String = ""
    @FocusState private var focusedField: Field?
    
    var body: some View {
        TextField("Add task", text: $toDoTask)
            .focused($focusedField, equals: .toDoTask)
            .padding()
            .toolbar {
                Button(action: {
                    if toDoTask.isEmpty {
                        focusedField = .toDoTask
                    } else {
                        saveTask()
                    }
                }) {
                    Text("Add to list")
                }
            }
        
    }
    
    func saveTask() {
        let newTask = Task(context: viewContext)
        newTask.title = toDoTask
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
    }
}
