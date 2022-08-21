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
            
            if isGenerated {
                mock
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
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
                GeometryReader { geo in
                    
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
                                .frame(maxWidth: geo.size.width, maxHeight: 75, alignment: .leading)
                                .background(material, in: RoundedRectangle(cornerRadius: 14))
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Top Category")
                                        .font(.footnote)
                                    Text("\(viewModel.generatedCategory.first ?? "")")
                                        .font(.headline)
                                }
                                .padding()
                                .frame(maxWidth: geo.size.width, maxHeight: 75, alignment: .leading)
                                .background(material, in: RoundedRectangle(cornerRadius: 14))
                            }
                            
                            
                            VStack(alignment: .leading) {
                                Text("Total Amount")
                                Spacer()
                                Text("$\(viewModel.generatedAmount, specifier: "%.2f")")
                                    .font(.system(.title, design: .rounded))
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: geo.size.width, maxHeight: 160, alignment: .topLeading)
                            .background(material, in: RoundedRectangle(cornerRadius: 14))
                            
                        }
                    }
                }
                
                
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text("\(selectedGeneratorType.rawValue)")
//                            .font(.system(size: 30, weight: .regular, design: .default))
//                        Spacer()
//                        Button {
//                            withAnimation {
//                                isGenerated = false
//                            }
//
//                        } label: {
//                            Image(systemName: "arrow.down")
//                                .font(.title)
//                                .foregroundColor(.themeThree)
//                                .shadow(radius: 10)
//                        }
//
//                    }
//
//
//                }
//
//                HStack(alignment: .center) {
//                    Text("$\(viewModel.generatedAmount, specifier: "%.2f")")
//
//                    Spacer()
//
//                }
//
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Top Category")
//                        .font(.headline)
//                        .opacity(0.5)
//                    Text(viewModel.generatedCategory.first ?? "")
//
//                    Text("Most Used payment")
//                        .font(.headline)
//                        .opacity(0.5)
//                    Text(viewModel.generatedPayment.first ?? "")
//
//                }
            }
        }
 
        .transition(.opacity)
        .onDisappear {
            viewModel.resetStats()
        }
        
        
        
    }
}


