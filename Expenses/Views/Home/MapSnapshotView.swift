//
//  MapSnapshotView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/9/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapSnapshotView: View {
    
    @State var amount: Double
    @State var gradient: LinearGradient
    @State var location: CLLocationCoordinate2D
    let span: CLLocationDegrees = 0.005
    
    @State private var snapshotImage: UIImage? = nil
    
    var body: some View {
        
        GeometryReader { geo in
            Group {
                if let image = snapshotImage {
                    Image(uiImage: image)
                        .transition(.opacity)
                        .overlay(
                            ZStack {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.body)
                                    .foregroundStyle(Material.ultraThin)
                                    .offset(x: 0, y: 30)
                                Text("$\(amount, specifier: "%.2f")")
                                    .foregroundStyle(gradient)
                                    .font(Font.system(.headline, design: .rounded))
                                    .padding()
                                    .background(Material.ultraThin, in:
                                        RoundedRectangle(cornerRadius: 14)
                                    )
                            }
                                .shadow(radius: 5)
                            ,
                            alignment: .center
                        )
                    
                } else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            HStack(spacing: 10) {
                                Text("Loading Map...")
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            }
                            .padding()
                            .background(Material.ultraThin, in: Capsule())
                            .shadow(radius: 10)
                            Spacer()
                        }
                        .foregroundColor(.themeThree)
                        .padding()
                        Spacer()
                    }
                    .background(Color(UIColor.secondarySystemBackground))

                }
            }
            .onAppear {
                    generateSnapshot(width: geo.size.width, height: geo.size.height)
            }
        }
        
    }
    
    func generateSnapshot(width: CGFloat, height: CGFloat) {
        
        // The region the map should display.
        let region = MKCoordinateRegion(
            center: self.location,
            span: MKCoordinateSpan(
                latitudeDelta: self.span,
                longitudeDelta: self.span
            )
        )
        
        // Map options.
        let mapOptions = MKMapSnapshotter.Options()
        mapOptions.region = region
        mapOptions.size = CGSize(width: width, height: height)
        mapOptions.showsBuildings = true
        
        // Create the snapshotter and run it.
        let snapshotter = MKMapSnapshotter(options: mapOptions)
        snapshotter.start { (snapshotOrNil, errorOrNil) in
            if let error = errorOrNil {
                print(error)
                return
            }
            if let snapshot = snapshotOrNil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation {
                        self.snapshotImage = snapshot.image
                    }
                }
            }
        }
    }
}
