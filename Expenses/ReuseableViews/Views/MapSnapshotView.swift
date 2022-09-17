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
    @State var location: CLLocationCoordinate2D
    
    let span: CLLocationDegrees = 0.005
    
    @State private var isMapLoaded: Bool = false
    @State private var snapshotImage: UIImage? = nil
    
    var body: some View {
        
        GeometryReader { geo in
            Group {
                if let image = snapshotImage {
                    Image(uiImage: image)
                        .resizable()
                        .transition(.opacity)
                        .overlay(
                            ZStack {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.body)
                                    .foregroundColor(.themeThree)
                                    .offset(x: 0, y: 30)
                                Text("$\(amount, specifier: "%.2f")")
                                    .font(Font.system(.headline, design: .rounded))
                                    .padding()
                                    .background(Material.ultraThin, in:
                                        RoundedRectangle(cornerRadius: 14)
                                    )
                            }
                                .offset(x: 0, y: -20)
                                .shadow(radius: 5)
                            ,
                            alignment: .center
                        )
                }
            }
            .onAppear {
                    generateSnapshot(width: geo.size.width, height: geo.size.height)
                print("Map: \(isMapLoaded)")
            }
            .onDisappear {
                snapshotImage = nil
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
        
        if snapshotter.isLoading == true {
            isMapLoaded = false
        } else {
            snapshotter.start { (snapshotOrNil, errorOrNil) in
                if let error = errorOrNil {
                    print(error)
                    return
                }
                if let snapshot = snapshotOrNil {
                    withAnimation {
                        isMapLoaded = true
                        self.snapshotImage = snapshot.image
                        print("Image generated")
                    }
                }
            }
        }
        
        
    }
}
