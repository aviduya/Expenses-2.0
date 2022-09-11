//
//  CoreDataView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/26/22.
//

import SwiftUI

struct CoreDataView: View {
    
    @EnvironmentObject var viewModel: CoreDataHandler
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Edit Transactions")
                    .font(Font.system(.title3, design: .default).weight(.bold))
                Spacer()
                EditButton()
            }
            .padding()
            
            Section {
                List {
                    ForEach(viewModel.headers, id: \.self) { header in
                        Section {
                            ForEach(viewModel.groupedByDate[header]!) { transactions in
                                HStack {
                                    Text(viewModel.returnDateShorthand(input: transactions.date))
                                        .foregroundColor(.red)
                                    Divider()
                                    Text(transactions.name ?? "Error")
                                    Spacer()
                                    Text("$\(transactions.amount, specifier: "%.2f")")
                                        .opacity(0.33)
                                }
                            }
                            .onDelete(perform: viewModel.deleteTransactions)
                        } header: {
                            HStack {
                                Image(systemName: "calendar")
                                Text(viewModel.returnMonth(input: header))
                                    .bold()
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .overlay {
            if viewModel.all.isEmpty {
                EmptyView(message: "Add a transaction")
            }
        }
    }
}
