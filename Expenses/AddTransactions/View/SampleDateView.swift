//
//  SampleDateView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/4/22.
//

import SwiftUI

struct SampleDateView: View {
    
    @Binding var date: Date
    
    var body: some View {
        DatePicker("", selection: $date, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .frame(maxHeight: 400)
            .padding()
    }
}

struct SampleDateView_Previews: PreviewProvider {
    static var previews: some View {
        SampleDateView(date: .constant(Date()))
    }
}
