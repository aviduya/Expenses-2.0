//
//  GroupBoxPickersView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/6/22.
//

import SwiftUI

struct GroupBoxPickersView: View {
    
    @Binding var categories: Categories
    @Binding var banks: Banks
    
    
    var body: some View {
        HStack {
            HStack {
                Menu(content: {
                    Section {
                        Picker("", selection: $categories) {
                            ForEach(Categories.allCases, id: \.self) { category in
                                HStack {
                                    Text(category.rawValue.capitalized).tag(category)
                                    Spacer()
                                    Image(systemName: category.icon)
                                }
                            }
                        }
                        
                    }
                }, label: {
                    Image(systemName: "list.bullet.indent")
                        .padding(.vertical)
                        .font(.title)
                })
                Text(categories.id)
                    .bold()
                
            }
            .modifier(GroupedModifier())
            
            HStack {
                
                Menu(content: {
                    Section {
                        Picker("", selection: $banks) {
                            ForEach(Banks.allCases, id: \.self) { category in
                                HStack {
                                    Text(category.rawValue.capitalized).tag(category)
                                    Spacer()
                                }
                            }
                        }
                        
                    }
                }, label: {
                
                    Image(systemName: "building.columns")
                        .padding(.vertical)
                        .font(.title)
                        
                })
                
                Text(banks.id)
                    .bold()
                
            }
            .modifier(GroupedModifier())
        }
    }
}

fileprivate struct GroupedModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        let material: Material = .thin
        
        content
            .frame(maxWidth: .infinity, minHeight: 75, alignment: .leading)
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))

    }
}
