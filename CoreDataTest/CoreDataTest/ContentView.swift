//
//  ContentView.swift
//  CoreDataTest
//
//  Created by Tomáš Valášek on 24.09.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State private var title: String = ""
    
    @SectionedFetchRequest<Bool, Item>(sectionIdentifier: \.isCompleted, sortDescriptors: [SortDescriptor(\.isCompleted)])
        private var itemSections
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            print (error)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        let item = Item(context: viewContext)
                        item.title = title
                        item.timestamp = Date()
                        save()
                        title = ""
                    }
                
                List {
                    ForEach(itemSections) { itemSection in
                        Section {
                            ForEach(itemSection) { item in
                                HStack {
                                        Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                                            .onTapGesture {
                                                item.isCompleted.toggle()
                                                save()
                                            }
                                        Text(item.title ?? "")
                                    }
                                }.onDelete { indexSet in
                                    let sections = Array(itemSection)
                                    for index in indexSet {
                                        let item = sections[index]
                                        viewContext.delete(item)
                                    }
                                    
                                    save()
                            }
                        } header: {
                            Text(itemSection.id ? "Completed" : "Pending")
                        }
                        
                    }
                }
                
                    .navigationTitle("Tasks")
            }.padding()
        }
        
    }
}
