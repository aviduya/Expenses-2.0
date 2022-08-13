//
//  ThresholdSettingView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/11/22.
//

import SwiftUI

struct ThresholdSettingView: View {
    
    @EnvironmentObject var settings: AppSettingsViewModel
    
    @State private var userValueThreshold: Double = 0.0
    
    var body: some View {
        
        let material: Material = .ultraThin
        
        NavigationLink {
            VStack {
                
                Text("$\(settings.userValueTreshold, specifier: "%.2f")")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                
                
                Divider()
                
                Section {
                    HStack{
                        TextField  ("\(settings.userValueTreshold)", value: $userValueThreshold, format: .currency(code: "usd"))
                        Spacer()
                        Button {
                            settings.setUserValueThreshold(value: userValueThreshold)
                        } label: {
                            Text("Set")
                        }
                        
                    }
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 16))
                } header: {
                    
                    HStack {
                        Text("Set Amount threshold.")
                            .font(.subheadline)
                            .opacity(0.33)
                        Spacer()
                    }
                    
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("$\(settings.belowValueThreshold, specifier: "%.2f")")
                                .appSettingsThresholdStyle(primary: .primaryGreen, secondary: .secondaryGreen)
                            
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.backward")
                                Text("Less Than")
                            }
                            .font(.title2)
                        }
                        
                        HStack {
                            Text("$\(settings.aboveValueThreshold, specifier: "%.2f")")
                                .appSettingsThresholdStyle(primary: .primaryOrange, secondary: .secondaryOrange)
                        
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.left.arrow.right")
                                Text("Range of")
                            }
                            .font(.title2)
                        }
                        
                        HStack(spacing: 10) {
                            Text("$\(settings.rangeOfValueThreshold, specifier: "%.2f")")
                                .appSettingsThresholdStyle(primary: .primaryRed, secondary: .secondaryRed)
                        
                            VStack(alignment: .center) {
                                Image(systemName: "arrow.right")
                                Text("Greater than")
                            }
                            .font(.title2)
                        }
                        
                    }
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 16))
                } footer: {
                    HStack {
                        Text("These colors computes the amount that was set to three tiers of spending amount. Good, Warning and Extreme to the amount that is set .")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                            .opacity(0.33)
                        Spacer()
                    }
                }
            }.padding()
        } label: {
            Text("Threshold")
        }
    }
}
