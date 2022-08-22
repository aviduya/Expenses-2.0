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
                    Button {
                        withAnimation {
                            isGenerated = false
                        }
                        
                    } label: {
                        Image(systemName: "arrow.down.forward.and.arrow.up.backward")
                            .font(.title)
                            .foregroundColor(.themeThree)
                    }

                }
                
                
                Group {
                    mock
                        .padding()
                        .background(material, in: RoundedRectangle(cornerRadius: 14))
                    if !isGeneratedEmpty {
                        Divider()
                        highlights
                    }
                    
                }
                
                .transition(.opacity)
                
            }
            Spacer()
            
            
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
        .onChange(of: selectedGeneratorType, perform: { newValue in
            
            isGenerated = false
            
            
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            if isGenerating {
                VStack(spacing: 5) {
                    ProgressView()
                        .tint(.themeThree)
                    Text("Generating Report")
                }
                .padding()
                .background(material, in: RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding()
    }
    
    var highlights: some View {
        
        Group {
            Text("Highlights")
                .opacity(0.33)
            HStack {
                Image(systemName: "building.columns")
                    .font(.title)
                Text("You have used your \(viewModel.generatedPayment.first ?? "") account \(viewModel.generatedPayment.count) times in this selected period.")
                
            }
            
            HStack {
                Image(systemName: "tag")
                    .font(.title)
                Text("Your favorite place to shop is at was \(viewModel.generatedMerchant.first ?? "").")
                
            }
            
            HStack {
                Image(systemName: "bag")
                    .font(.title)
                Text("You mostly spend your money on \(viewModel.generatedCategory.first ?? "") during this set period.")
                
            }
            
        }
        
        
        
        
        
    }
    
    
    
    var mock: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            if isGeneratedEmpty {
                VStack {
                    Text("No Transactions Recorded")
                        .font(.title)
                    Button {
                        isGenerated = false
                    } label: {
                        Text("Dissmiss")
                    }
                    
                }
            } else {
                
                
                VStack(alignment: .leading) {
                    Text("Spending Statistics")
                        .opacity(0.33)
                    HStack {
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Top Payment")
                                    .font(.footnote)
                                Text("\(viewModel.generatedPayment.first ?? "")" + " Card")
                                    .font(.headline)
                            }
                            
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
                            .background(material, in: RoundedRectangle(cornerRadius: 14))
                            .shadow(radius: 5)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Top Category")
                                    .font(.footnote)
                                Text("\(viewModel.generatedCategory.first ?? "")")
                                    .font(.headline)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
                            .background(material, in: RoundedRectangle(cornerRadius: 14))
                            .shadow(radius: 5)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Total Amount")
                            Spacer()
                            Text("$\(viewModel.generatedAmount, specifier: "%.2f")")
                                .font(.system(.title, design: .rounded))
                            Spacer()
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .topLeading)
                        .background(material, in: RoundedRectangle(cornerRadius: 14))
                        .shadow(radius: 5)
                        
                    }
                }
                
                
                
            }
        }
        .onDisappear {
            viewModel.resetStats()
        }
        
        
        
    }
}


