//
//  CardView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/22/22.
//

import SwiftUI
import MapKit

struct CardView: View {
    
    @EnvironmentObject var settings: AppSettingsViewModel
    @EnvironmentObject var locationHandler: LocationsHandler
    @AppStorage("threshold") var setThreshold: Double = 0.0
    @StateObject var vm = CardViewModel()
    
    @State var item: String
    @State var date: Date
    @State var amount: Double
    @State var category: String
    @State var merchant: String
    @State var bank: String 
    @State var region: CLLocationCoordinate2D
    @State var long: Double
    @State var lat: Double
    
    @State private var isExpanded: Bool = false

    var handledAddress: String {
        
        var placeholder = ""
        
        if vm.viewAdress == ", , " {
            placeholder = "Could not determine Location"
        } else {
            placeholder = vm.viewAdress
        }
        
        return placeholder
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.title3)
                        Text("\(vm.formatDate(date))")
                            .font(Font.system(.callout, design: .default))
                            .opacity(0.5)
                    }
                    Spacer()
                    Image(systemName: isExpanded ? "info.circle.fill":"info.circle")
                        .foregroundColor(.themeThree)
                        .font(.system(size: 20))
                        .shadow(radius: 10)
                        .onTapGesture {
                            if locationHandler.isAuthorized {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }
                        }
                    
                }
                
                if isExpanded {
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        CardRowView(sysImage: "dollarsign.circle", text: String(format: "%.2f", amount))
                        CardRowView(sysImage: "bag", text: merchant)
                        CardRowView(sysImage: "list.bullet", text: category)
                        CardRowView(sysImage: "building.columns", text: bank + " Card")
                        CardRowView(sysImage: "mappin.and.ellipse", text: locationHandler.isAuthorized ? handledAddress : "Location Disabled")
                    }
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            MapSnapshotView(amount: amount, location: region)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        )
        .padding(.bottom, 50)
        .onAppear {
            vm.getAddress(lat, long)
            if !locationHandler.isAuthorized {
                isExpanded = true
                region = CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.03118)
            }
        }
        .onDisappear {
            if locationHandler.isAuthorized {
                isExpanded = false
            }
        }
    }
}

fileprivate struct CardRowView: View {
    
    var sysImage: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: sysImage)
                .frame(width: 20, height: 20)
            Divider()
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .font(.headline)
    }
}
