//
//  GeneratorView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/17/22.
//

import SwiftUI

struct GeneratorView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = GeneratorViewModel()
    
    @State private var isGenerating: Bool = false
    @State private var isGenerated: Bool = false
    
    
    @State private var selectedGeneratorType: GeneratedTypes = .yesterday {
        didSet {
            isGenerated = false
        }
    }
    
    var body: some View {
            VStack {
                Text("Generate Spending Report")
                    .font(Font.system(.title2, design: .default).weight(.bold))
                
                Picker("Select Me", selection: $selectedGeneratorType) {
                    ForEach(GeneratedTypes.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                HStack {
                    Button {
                        withAnimation {
                            isGenerating = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            withAnimation {
                                
                                viewModel.generateReport(type: selectedGeneratorType, customStart: nil, customEnd: nil) {
                                    viewModel.publishReport()
                                }
                                
                                isGenerated = true
                                isGenerating = false
                            }
                        }
                    } label: {
                      Text("Generate")
                    }
                }
                
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .overlay {
                if isGenerating {
                        VStack {
                            Text("Generating Report")
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        .padding()
                        .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10))
                    
                }
                if isGenerated {
                    mockView
                        .padding()
                        .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10))
                        .padding()
                        .onDisappear {
                            viewModel.resetStats()
                        }
                }

            }
            
    }
    
    
    var mockView: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Spent This \(selectedGeneratorType.rawValue)")
                        .font(.system(size: 30, weight: .regular, design: .default))
                    Spacer()
                    Button {

                        isGenerated = false
                        
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title2)
                            .foregroundColor(.themeThree)
                            .shadow(radius: 10)
                    }
                    
                }
                
                
            }
            
            HStack(alignment: .center) {
                Text("$\(viewModel.generatedAmount, specifier: "%.2f")")
                
                Spacer()
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(viewModel.generatedCategory.first ?? "")
                
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(viewModel.generatedPayment.first ?? "")
                
            }
            
        }
        .transition(.scale)
    }
}


