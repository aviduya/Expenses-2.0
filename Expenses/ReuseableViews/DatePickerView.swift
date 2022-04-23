//
//  DatePickerView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var input: Date
    
    let material: Material = .thin
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text(date(date: input))
                    .font(.title)
                    .bold()
                Text(am(date: input))
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            
            Spacer()
            
            DatePicker("", selection: $input, in: ...Date())
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            Spacer()
            Button(action: {
                mode.wrappedValue.dismiss()
            }) {
                Text("Set Date & Time")
            }.buttonStyle(CustomButtonStyle())
        }
        .padding()
    }
    
    private func date(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        
        return formatter.string(from: date)
    }
    
    private func am(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: date)
    }
}

struct DatePickerView: View {
    
    let material: Material = .thin
    
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .font(.title)
            Text(convertDate(date: date))
                .bold()
            Spacer()
            NavigationLink(destination: CalendarView(input: $date)) {
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


struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()))
    }
}
