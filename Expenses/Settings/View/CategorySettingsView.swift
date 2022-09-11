//
//  CategorySettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/11/22.
//

import SwiftUI

struct CategorySettingsView: View {
    @EnvironmentObject var settings: AppSettingsViewModel
    @State private var category: String  = ""
    
    var body: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        TextField("Enter a Category", text: $category)
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.themeThree)
                            .onTapGesture {
                                settings.addElement(new: category, element: &settings.categories, key: settings.categoryKey)
                                category = ""
                            }
                            .shadow(radius: 10)
                            .disabled(category.isEmpty)
                    }
                    
                } footer: {
                    Text("A list of category that is associated with the transaction.")
                }
                
                Section {
                    ForEach(settings.categories, id: \.self) { i in
                        HStack {
                            Text(i)
                            Spacer()
                        }
                    }
                    .onDelete(perform: settings.removeCategory)
                } header: {
                    HStack {
                        Image(systemName: "checklist")
                            .foregroundColor(.green)
                        Text("Active Categories")
                    }
                }
            }
        } label: {
            Text("Categories")
        }
    }
}
