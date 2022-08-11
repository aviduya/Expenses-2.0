//
//  BankSettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/11/22.
//

import SwiftUI

struct BankSettingsView: View {
    @EnvironmentObject var settings: AppSettingsViewModel
    @State private var bank: String = ""

    
    var body: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        TextField("Add a Bank", text: $bank)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                settings.addElement(new: bank, element: &settings.banks, key: settings.bankKey)
                                bank = ""
                            }
                            .disabled(bank.isEmpty)
                    }
                    
                } footer: {
                    Text("A list of accounts that are displayed when adding a transaction.")
                }
                
                Section {
                    ForEach(settings.banks, id: \.self) { i in
                        Text(i)
                    }
                    .onDelete(perform: settings.removeBank)
                } header: {
                    HStack {
                        Image(systemName: "building.columns")
                            .foregroundColor(.orange)
                        Text("Active Accounts")
                    }
                }
                
            }
        } label: {
            Text("Banks")
        }
    }
}
