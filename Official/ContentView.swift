//
//  ContentView.swift
//  Official
//
//  Created by Joshua Yamamoto-Kim on 11/15/23.
//

import SwiftUI
import SwiftData
import UIKit
import RealityKit
import AVFoundation

struct ContentView: View {
    struct Item: Identifiable {
        let name: String
        let id = UUID()
        var isSelected: Bool = false
    }
    
    @State private var items: [Item] = []
    @State private var newName: String = ""
    @State private var isAddSheetPresented = false
    
    @State private var selectedItemId: UUID?
    
    var body: some View {
        VStack {
            HStack {
                Text("Rooms")
                    .font(.title)
                    .padding(.leading, 16)
                
                Spacer()
                
                Menu {
                    // Button("Add", action: add)
                    Button("Add", action: {
                        isAddSheetPresented = true
                    })
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 16)
            }
            .padding(.bottom, 8)
            
            List {
                ForEach(items) { item in
                    VStack {
                        Spacer()
                        NavigationLink(
                            destination: Text("Details for \(item.name)"),
                            tag: item.id,
                            selection: $selectedItemId
                        ){
                            EmptyView()
                        }
                        .hidden()
                        
                        Button(action: {
                            toggleSelection(for: item)
                        }) {
                            Text(item.name)
                                .padding(.vertical, 8)
                        }
                        .frame(width: 300, height: 100)
                        .background(item.isSelected ? Color.blue : Color.clear)
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
        }
        .sheet(isPresented: $isAddSheetPresented) {
            AddItemSheet { newName in
                withAnimation {
                    let newItem = Item(name: newName)
                    items.insert(newItem, at: 0)
                    
                    selectedItemId = newItem.id
                }
            }
        }
        .navigationTitle("List")
        .navigationBarItems(trailing: EditButton())
        
        HStack(spacing: 35) {
            
            NavigationLink(destination: ScreenView()) {
                Image(systemName: "cart.badge.plus")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }
            
            Menu {
                // Button("Dashboard", action: dashboard)
                Button("Dashboard", action: {
                    // Need
                })
            } label: {
                Image(systemName: "squares.leading.rectangle.fill")
                    .imageScale(.large)
                    .foregroundColor(.gray)
                Text("Dashboard")
                    .foregroundColor(.gray)
            }
            
            Menu {
                // Button("Upload", action: upload)
                Button("Upload", action: {
                    // Need
                })
            } label: {
                Image(systemName: "icloud.and.arrow.down")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }

            Menu {
                // Button("Delete", action: delete)
                Button("Settings", action: {
                    // Need
                })
            } label: {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 16)
        }
        .padding(.bottom, 8)
    }
    
    private func delete(at offsets: IndexSet) {
        withAnimation {
            items.remove(atOffsets: offsets)
        }
    }
    
    private func toggleSelection(for item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isSelected.toggle()
        }
    }
}
    struct AddItemSheet: View {
        @State private var newName:String = ""
        @Environment(\.presentationMode) var presentationMode
        var onAdd: (String) -> Void
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("New Item Name ")) {
                        TextField("Enter Name", text: $newName)
                    }
                }
                .navigationTitle("Add Item")
                .navigationBarItems(
                    trailing: Button("Done") {
                        onAdd(newName)
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }

    struct ShoppingScreenView: View {
        var body: some View {
            Text("This is the shopping screen!")
                .padding()
                .navigationTitle("Shopping")
        }
    }

    
    #Preview {
        ContentView()
            .modelContainer(for: Item.self, inMemory: true)
    }
