//
//  DootyListView.swift
//  Dooty
//
//  Created by Vladislavs Buzinskis on 24/07/2022.
//

import SwiftUI

struct DootyListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)],
        animation: .default
    )
    
    public var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { listedTask in
                    NavigationLink(
                        destination: ViewTask(task: listedTask, editableTask: listedTask.title!)
                    ) {
                        Text(listedTask.title!)
                            .lineLimit(1)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Dooties")
            .toolbar {
                ToolbarItem {
                    NavigationLink(
                        destination: AddView()
                    ) {
                        Label(
                            "Add task",
                            systemImage: "plus.circle.fill"
                        )
                    }
                }
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)
            
            // Optional
            try? viewContext.save()
            
        }
    }
}

struct DootyListView_Previews: PreviewProvider {
    static var previews: some View {
        DootyListView()
    }
}
