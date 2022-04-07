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
                Image(systemName: categories.icon)
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
                    Text(categories.id)
                })
                
                
                
            }
            .modifier(GroupedModifier())
            
            HStack {
                Image(systemName: "creditcard.circle")
                    .font(.title)
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
                    Text(banks.id)
                        .bold()
                })
                
                
                
            }
            .modifier(GroupedModifier())
        }
    }
}

fileprivate struct GroupedModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .frame(maxWidth: .infinity, minHeight: 75, alignment: .leading)
            .clipped()
            .background(RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(.systemFill)))
    }
}

fileprivate struct CardGroupBoxStyle: GroupBoxStyle {
    
    let material: Material = .thin
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(material)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        
    }
}
