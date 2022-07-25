//
//  ViewTask.swift
//  Dooty
//
//  Created by Vladislavs Buzinskis on 25/07/2022.
//

import SwiftUI


struct ViewTask: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var task: Task
    @State var editableTask: String
    
    var body: some View {
        TextField("Task", text: $editableTask, onEditingChanged: { typing in
            if typing == false {
                saveEditedTask()
            }
        })
        .padding()
        .font(.system(size: 30))
        .toolbar {
            Button(action: {
                deleteTask()
            }) {
                Label(
                    "Delete task",
                    systemImage: "xmark.bin.circle.fill"
                )
                .foregroundColor(Color(.red))
            }
        }
        
    }
    
    func saveEditedTask() {
        task.title = editableTask
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteTask() {
        task.title = editableTask
        viewContext.delete(task)
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}

struct ViewTask_Previews: PreviewProvider {
    static var viewContext = PersistenceController.preview.container.viewContext
    static var previews: some View {
        ViewTask(
            task: Task(context: viewContext),
            editableTask: "test"
        )
    }
}
