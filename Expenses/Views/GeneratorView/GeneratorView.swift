//
//  GeneratorView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/17/22.
//

import SwiftUI

struct GeneratorView: View {
    
    @State private var tabCount: Int = 1
    
    var body: some View {
        NavigationView {
            TabView{
                Text("test")
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                }
                mockView
                    .tabItem {
                                        Label("Order", systemImage: "square.and.pencil")
                                    }
            }
        }
    }
    
    
    var mockView: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                
            }
            
            HStack(alignment: .center) {
                Text("$200")
                    
                Spacer()
                Text("-200")
                    .foregroundColor(.red)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text("Amex")
                
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text("Bills")
                   
            }
            
        }
    }
    
}

