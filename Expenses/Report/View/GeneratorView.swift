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
    @State private var isCustom: Bool = false
    @State private var isShowingPicker: Bool = false
    @State private var isButtonPressed: Bool = false
    
    @State private var customStart: Date = Date()
    @State private var customEnd: Date = Date()
    
    
    @State private var selectedGeneratorType: GeneratorViewModel.GeneratedTypes = .yesterday
    
    private let material: Material = .ultraThinMaterial
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Spending Report")
                .font(Font.system(.title3, design: .default).weight(.bold))
            header
            
            if isCustom {
                customDateRangePicker
            }
            
            if isGenerated {
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("\(selectedGeneratorType.rawValue)'s Report")
                                .font(.title3)
                                .foregroundColor(.themeThree)
                            Spacer()
                        }
                        HighlightView
                    }
                }
                .padding(.top, 20)
                .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
            } else {
                EmptyView(message: "Generate a Report")
            }
        }
        .onChange(of: selectedGeneratorType, perform: { _ in
            withAnimation {
                if selectedGeneratorType == .custom {
                    isCustom = true
                    isShowingPicker = true
                } else {
                    isCustom = false
                }
            }
            withAnimation {
                isGenerated = false
            }
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay() {
            if isGenerating {
                loading
            }
        }
        .padding(15)
    }
}


extension GeneratorView {
    
    var HighlightView: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            if isGeneratedEmpty {
                VStack {
                    Text("No Transactions Recorded within timeframe")
                        .font(.title)
                }
                .padding()
                .background(Material.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
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
    
    var header: some View {
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
                    isShowingPicker = false
                    isButtonPressed.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        viewModel.generateReport(type: selectedGeneratorType, customStart: customStart, customEnd: customEnd) {
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
                    isButtonPressed = false
                }
                withAnimation {
                    isGenerated = false
                }
            } label: {
                HStack {
                    Text("Generate")
                    Image(systemName: "arrow.clockwise")
                        .rotationEffect(.degrees(isButtonPressed ? 360 : 0))
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
    
    var customDateRangePicker: some View {
        VStack {
            HStack {
                Text("Edit Date Range")
                Spacer()
                Image(systemName: isShowingPicker ? "chevron.right.circle.fill" : "chevron.right.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.themeThree)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isShowingPicker.toggle()
                            isGenerated = false
                        }
                    }
                    .rotationEffect(.degrees(
                        isShowingPicker ? 90 : 0
                    ))
            }
            if isShowingPicker {
                VStack(alignment: .leading, spacing: 10) {
                    Divider()
                    DatePicker("Start", selection: $customStart, in: ...Date(), displayedComponents: .date)
                    DatePicker("End", selection: $customEnd, in: ...Date(), displayedComponents: .date)
                }
            }
        }
        .padding()
        .materialBackground()
    }
}
