//
//  GroupBoxPickersView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/6/22.
//

import SwiftUI

struct GroupBoxPickersView: View {
    
    @Binding var categoryInput: String
    @Binding var bankInput: String
    
    @ObservedObject var am = AppModel()
    
    var body: some View {
        HStack {
            HStack {
                Menu(content: {
                    Section {
                        Picker("", selection: $categoryInput) {
                            ForEach(am.categories) { category in
                                HStack {
                                    Text(category.id)
                                        .background(Color.red)
                                    Spacer()
                                    Image(systemName: category.symbol)
                                }
                                
                                
                            }
                        }
                        
                    }
                }, label: {
                    catLabel
                })
            }
            
            HStack {
                Menu(content: {
                    Section {
                        Picker("", selection: $bankInput) {
                            ForEach(am.banks) { bank in
                                HStack {
                                    Text(bank.id)
                                    Spacer()
                                }
                            }
                        }
                        
                    }
                }, label: {
                    bankLabel
                })
            }
            
        }
    }
}

fileprivate struct GroupedModifier: ViewModifier {
    func body(content: Content) -> some View {
        let material: Material = .thin
        
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}


extension GroupBoxPickersView {
    
    var bankLabel: some View {
        VStack {
            if bankInput.isEmpty {
                Text("Bank")
            } else {
                Text(bankInput)
            }
            
        }
        .font(.system(size: 18, weight: .bold))
        .modifier(GroupedModifier())
    }
    
    var catLabel: some View {
        VStack {
            
            if categoryInput.isEmpty {
                Text("Category")
            } else {
            Text(categoryInput)
             
            }
        }
        .font(.system(size: 18, weight: .bold))
        .modifier(GroupedModifier())
    }
}
