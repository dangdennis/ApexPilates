//
//  ClientsView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct ClientsView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Client.name, ascending: false)]
    ) var allClients: FetchedResults<Client>
    
    @State private var name = ""
    
    var body: some View {
        return NavigationView {
            VStack(alignment: .leading) {
                TextField("Enter client's name", text: $name, onCommit: addClient)
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
                
                List(allClients, id: \.id) { client in
                    NavigationLink(destination: DetailedClientView(client: client)) {
                        Text(client.name ?? "")
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("Clients"))
        }
    }
    
    func addClient() {
        let newClient = Client(context: context)
        newClient.id = UUID()
        newClient.name = self.name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        reset()
    }
    
    func reset() {
        name = ""
    }
}

struct ClientsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = persistentStore.persistentContainer.viewContext
        return ClientsView().environment(\.managedObjectContext, context)
    }
}
