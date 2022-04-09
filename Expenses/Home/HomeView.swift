//
//  HomeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/8/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var isPresented: Bool = false
    @StateObject var core = AddTransactionsVM()
    
    var body: some View {
        List {
            ForEach(core.savedEntities, id: \.self) { e in
                VStack {
                    Text("\(e.amount)")
                    Text(e.name ?? "Error")
                }

                
           
            }
            .onDelete(perform: core.deleteTransactions)
        Button(action: {isPresented.toggle()}, label: {Text("Press me")})

        .sheet(isPresented: $isPresented) {
            AddTransactionView()
        }
        
        
    }
}

}
