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
    @State private var address: String = ""
    
   
    func getAdress() {
        let location = CLLocation(latitude: lat, longitude: long)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            address = placemark.postalAddressFormatted ?? ""
          
        }
    }
    
    private var gradientBackground: LinearGradient {
        
        func returnGradient(_ color1: Color, _ color2: Color) -> LinearGradient {
            return LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
        }
        
        let green = returnGradient(.primaryGreen, .primaryOrange)
        let orange = returnGradient(.primaryOrange, .secondaryOrange)
        let red = returnGradient(.primaryRed, .secondaryRed)
        
        var thresholdStart: Double {
            let t = setThreshold
            return  t / 3
        }
        
        var thresholdEnd: Double {
            let t = setThreshold
            return t / (2/3)
        }
        
        switch amount {
        case 0..<thresholdStart:
            return green
        case thresholdStart...thresholdEnd:
            return orange
        case setThreshold...:
            return red
        default:
            return returnGradient(.black, .black)
        }
        
    }
    
    var todayFormatter: String {
        
        let input = Calendar.current.dateComponents([.day], from: date)
        let dateTo = Calendar.current.dateComponents([.day], from: Date())
        let yesterday = Calendar.current.dateComponents([.day], from: Date().getYesterday() ?? Date())
        
        
        if input == dateTo {
            return "Today"
        } else if input == yesterday {
            return "Yesterday"
        }
        return date.formatted()
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.title3)
                        Text("\(todayFormatter)")
                            .font(Font.system(.callout, design: .default))
                            .opacity(0.5)
                    }
                    Spacer()
                    Image(systemName: isExpanded ? "info.circle.fill":"info.circle")
                        .foregroundColor(.themeThree)
                        .font(.system(size: 20))
                        .shadow(radius: 10)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                    
                }
                if isExpanded == true {
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "dollarsign")
                                .frame(width: 20, height: 20)
                            Divider()
                            Text("\(amount, specifier: "%.2f")")
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "bag")
                                .frame(width: 20, height: 20)
                            Divider()
                            Text(merchant)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "list.bullet")
                                .frame(width: 20, height: 20)
                            Divider()
                            Text(category)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "building.columns")
                                .frame(width: 20, height: 20)
                            Divider()
                            Text(bank)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "house")
                                .frame(width: 20, height: 20)
                            Divider()
                            Text(address)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                    .font(.headline)
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 14))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            MapSnapshotView(amount: amount, gradient: gradientBackground, location: region)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        )
        .padding(.bottom, 50)
        .onAppear {
            getAdress()
        }
        .onDisappear {
            isExpanded = false
        }
    }
}
