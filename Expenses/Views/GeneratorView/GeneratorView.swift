//
//  GeneratorView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/17/22.
//

import SwiftUI

struct GeneratorView: View {
    @StateObject private var viewModel = GeneratorViewModel()
    
    @State private var isGenerated: Bool = false
    @State private var tabCount: Int = 1
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Generate Spending Report")
                .font(Font.system(.title2, design: .default).weight(.bold))
            Spacer()
            
            TabView(selection: $tabCount) {
                
                Button {
                    withAnimation {
                        tabCount = 2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            isGenerated = true
                            viewModel.generateWeekReport()
                        }
                        
                    }
                    //generate 1 week report
                    
                } label: {
                    Text("Generate This week")
                }
                .onAppear {
                    withAnimation {
                        tabCount = 1
                    }
                    
                }
                
                VStack {
                    if isGenerated {
                        mockView
                            .transition(.move(edge: .top))
                    } else {
                        Text("Generating Report")
                        ProgressView()
                    }
                }
                .tag(2)
                
                
                
            }
            .tabViewStyle(PageTabViewStyle())
            
        }
        .padding()
        
        
        
    }
    
    
    var mockView: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                
            }
            
            HStack(alignment: .center) {
                Text("\(viewModel.generatedAmount)")
                
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
        .onAppear {
            
        }
    }
    
}

