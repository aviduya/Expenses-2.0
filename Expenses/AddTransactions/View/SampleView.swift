//
//  SampleView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/4/22.
//

import SwiftUI

struct SampleView: View {
    
    let material: Material = .thin
    
    @Binding var date: Date
    
    
    var body: some View {
        HStack {
            Image(systemName: "calendar.circle")
                .font(.title)
            Text(convertDate(date: date))
                .bold()
            Spacer()
            NavigationLink(destination: SampleDateView (date: $date)) {
                HStack {
                    Text("Select Date")
                    Image(systemName: "chevron.right")
                }
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .clipped()
        .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
    
    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM d, YYYY"
        
        return formatter.string(from: date)
    }
    
}
