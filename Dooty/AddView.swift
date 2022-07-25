//
//  AddView.swift
//  Dooty
//
//  Created by Vladislavs Buzinskis on 24/07/2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Returns back to list when saving the task
    @Environment(\.presentationMode) var presentationMode
    
    
    @State var toDoTask: String = ""
    @FocusState var titleField: Bool
    
    var body: some View {
        VStack {
            TextField("Add Dootie", text: $toDoTask)
                .focused($titleField)
                .submitLabel(.done)
                .onSubmit {
                    saveTask()
                }
                .padding()
                .font(.system(size: 30))
                .toolbar {
                    Button(action: {
                        saveTask()
                    }) {
                        Text("Add to list")
                    }
                }
                .onAppear {
                    // Hack for SwiftUI to display keyboard in TextField
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        titleField = true
                    }
                }
                .padding()
            
            Spacer()
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
