//
//  GroupBoxPickersView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/6/22.
//

import SwiftUI

struct GroupBoxPickersView: View {
    
    @EnvironmentObject var settings: AppSettingsViewModel
    
    //TODO: Have the buttons disbales if categories and banks are empty. 
    
    @Binding var categoryInput: String
    @Binding var bankInput: String
    var selectedColor: Color = .clear
    
    var body: some View {
        HStack {
            HStack {
                Menu(content: {
                    Section {
                        Picker("", selection: $categoryInput) {
                            ForEach(settings.categories, id: \.self) { category in
                                HStack {
                                    Text(category)
                                        .background(Color.red)
                                        .disabled(settings.categories.isEmpty)
                                    Spacer()
                            
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
                            ForEach(settings.banks, id: \.self) { bank in
                                HStack {
                                    Text(bank)
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
