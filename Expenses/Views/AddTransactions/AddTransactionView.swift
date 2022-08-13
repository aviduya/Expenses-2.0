//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: AppSettingsViewModel
    @EnvironmentObject var locationHandler: LocationsHandler
    @StateObject var vm = AddTransactionsViewModel()
    
    @State private var isLocationLoaded: Bool = false
    @State private var counter: Int = 0
    @State private var model =
    AddTransactionsModel(
        amount:
            nil,
        name:
            "",
        bank:
            "",
        merchant:
            "",
        category:
            "",
        date:
            Date(),
        coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    )
    // MARK: Main View
    
    let material: Material = .ultraThin
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    header
                    
                    locationIndicator
                    
                    formBox
                }
                
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addTransactionButton
                }
            }
        }
        .onAppear {
            locationHandler.getSnapshotOfLocation {
                model.coordinate.longitude = locationHandler.lastSeenLocation?.coordinate.longitude ?? 0.0
                model.coordinate.latitude = locationHandler.lastSeenLocation?.coordinate.latitude ?? 0.0
                withAnimation {
                    isLocationLoaded = true
                }
            }
        }
        .alert("Complete Details", isPresented: $vm.isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
        .overlay(settings.areOptionsEmpty ? emptyTransactionsView : nil)
    }
}

// MARK: Extension of AddTransactionsView


extension AddTransactionView {
    
    // MARK: Empty transactions view
    
    private var emptyTransactionsView: some View {
        VStack {
            Text("Add an Bank & Catergory in settings to get started.")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .ignoresSafeArea()
        
    }
    
    // MARK: Save Transactions
    
    private var addTransactionButton: some View {
        
        Button(action: {
            vm.saveTransaction(
                amount:
                    model.amount,
                name:
                    model.name,
                bank:
                    model.bank,
                merchant:
                    model.merchant,
                category:
                    model.category,
                date:
                    model.date,
                coordinate: model.coordinate)
                {
                    dismiss()
                }
        }) {
            Text("Save")
        }
        .foregroundColor(.themeThree)
        
        
    }
    
    // MARK: Header and title
    
    private var header: some View {
        VStack(alignment: .leading) {
            
            if model.name.isEmpty {
                Text("Item...")
                    .foregroundColor(.themeThree)
                    .addTransactionTitleStyle()
                    .opacity(0.33)
            } else {
                Text(model.name)
                    .foregroundColor(.themeThree)
                    .addTransactionTitleStyle()
            }
            
            Text("$\(model.amount ?? 0.0, specifier: "%.2f")")
                .foregroundColor(.themeThree)
                .font(Font.system(.largeTitle, design: .rounded).weight(.bold))
            
            Divider()
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: Main transactions form
    
    private var formBox: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Transaction Details")
                .font(.subheadline)
                .opacity(0.30)
            
            InputValueField(input: $model.amount, isValidated: $vm.areFieldsValid)
                .foregroundColor(.themeThree)
            
            
            InputTextField(input: $model.name, isValidated: $vm.areFieldsValid, placeholder: "Item...")
                .foregroundColor(.themeThree)
            
            InputTextField(input: $model.merchant, isValidated: $vm.areFieldsValid, placeholder: "Merchant...")
                .foregroundColor(.themeThree)
            
            DatePickerView(date: $model.date)
                .foregroundColor(.themeThree)
            
            GroupBoxPickersView(categoryInput: $model.category, bankInput: $model.bank)
                .foregroundColor(.themeThree)
            
        }
        .padding()
        
    }
    
    private var locationIndicator: some View {

        VStack {
            
            if isLocationLoaded == false {
                ProgressView {
                    Text("Loading")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .progressViewStyle(CircularProgressViewStyle())
            } else {
                HStack {
                    Image(systemName: "checkmark.circle")
                        .frame(maxWidth: 20, maxHeight: 20)
                        .padding(.horizontal, 10)
                        .font(.title)
                    Text("Location Loaded")
                        .font(Font.headline.weight(.bold))
                }
                .foregroundColor(.themeThree)
                .transition(.opacity)
            }
            
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .clipped()
        .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .padding(.horizontal)
        

    }
    
}

