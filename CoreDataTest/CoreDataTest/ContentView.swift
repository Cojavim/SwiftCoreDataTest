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
                
                
                
                    .navigationTitle("Tasks")
            }.padding()
        }
        
    }
}
