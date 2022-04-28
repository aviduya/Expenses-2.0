//
//  GridView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/23/22.
//

import SwiftUI

struct GridView: View {
    @StateObject var dm = CoreDataHandler.shared
    
    var body: some View {
            LazyVGrid(columns: [GridItem(.flexible())]) {
                ForEach(dm.savedEntities) { t in
                    GroupBox(content: {
                        Text(t.name ?? "")
                    }, label: {
                        Text("\(t.amount)")
                    })
                }
            }
        
        
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}


