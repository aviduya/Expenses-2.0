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
    @State private var isGeneratedEmpty: Bool = false
    
    @State private var selectedGeneratorType: GeneratorViewModel.GeneratedTypes = .yesterday
    
    private let material: Material = .ultraThinMaterial
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Generate Spending Report")
                .font(Font.system(.title2, design: .default).weight(.bold))
            
            Spacer()
            if isGenerated {
                HStack {
                    Text("\(selectedGeneratorType.rawValue)'s Report")
                        .font(.title)
                        .foregroundColor(.themeThree)
                    Spacer()
                }
                HighlightView
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 14))
                    .transition(.opacity)
                
            }
            Spacer()
            
            footer
            
        }
        .onChange(of: selectedGeneratorType, perform: { newValue in
            isGenerated = false
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            if isGenerating {
                loading
            }
        }
        .padding()
    }
}


extension GeneratorView {
    
    var HighlightView: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            if isGeneratedEmpty {
                VStack {
                    Text("No Transactions Recorded")
                        .font(.title)
                    
                }
            } else {
                HighlightsSubView(
                    payment: viewModel.generatedPayment.first,
                    category: viewModel.generatedCategory.first,
                    merchant: viewModel.generatedMerchant.first,
                    amount: viewModel.generatedAmount,
                    paymentAmount: viewModel.generatedPayment.count)
                
            }
        }
        .onDisappear {
            viewModel.resetStats()
        }
    }
    
    var footer: some View {
        HStack {
            Picker("Select Me", selection: $selectedGeneratorType) {
                ForEach(GeneratorViewModel.GeneratedTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                        .bold()
                        .foregroundColor(.themeThree)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(material, in: RoundedRectangle(cornerRadius: 14))
            Button {
                withAnimation {
                    isGenerating = true
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        
                        viewModel.generateReport(type: selectedGeneratorType, customStart: nil, customEnd: nil) {
                            viewModel.publishReport()
                            isGeneratedEmpty = false
                            print("success")
                        } none: {
                            isGeneratedEmpty = true
                            print("none")
                        }
                        
                        isGenerated = true
                        isGenerating = false
                        
                    }
                }
                withAnimation {
                    isGenerated = false
                }
                
            } label: {
                HStack {
                    Text("Generate")
                    Image(systemName: "arrow.clockwise")
                    
                }
                
                
            }
            .foregroundColor(.themeThree)
            .padding()
            .frame(maxHeight: 50)
            .background(material, in: RoundedRectangle(cornerRadius: 14))
            
        }
    }
    
    var loading: some View {
        VStack(spacing: 5) {
            ProgressView()
                .tint(.themeThree)
            Text("Generating Report")
        }
        .padding()
        .background(material, in: RoundedRectangle(cornerRadius: 14))
        
    }
}
