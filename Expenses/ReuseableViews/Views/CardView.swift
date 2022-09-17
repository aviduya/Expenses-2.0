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

    @StateObject var vm = CardViewModel()
    
    @State var item: String
    @State var date: String
    @State var amount: Double
    @State var category: String
    @State var merchant: String
    @State var bank: String
    @State var location: CLLocationCoordinate2D
    
    @State private var isMapLoaded: Bool = false
    @State private var isExpanded: Bool = false

    var handledAddress: String {
        if vm.viewAdress.count < 10 {
            return "Location was not saved."
        } else {
            return vm.viewAdress
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.title3)
                        Text(date)
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
            .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            MapSnapshotView(amount: amount, location: location)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        )
        .onAppear {
            vm.getAddress(location: location)
            if !locationHandler.isAuthorized {
                isExpanded = true
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
