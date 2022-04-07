////
////  GroupBoxView.swift
////  Expenses
////
////  Created by Anfernee Viduya on 4/5/22.
////
//
//import SwiftUI
//
//struct GroupBoxView: View {
//
//    @State var output1: Categories = .personal
//    @State var output2: String = ""
//
//    let testValue: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
//    let testValue2: [String] = ["Some Item 1", "Some Item 2", "Some Item 3"]
//
//
//
//    var body: some View {
//        HStack {
//            GroupBox(label:
//                        HStack {
//                Image(systemName: "creditcard")
//                Text("Category")
//            },
//                     content: {
//                Picker("Something", selection: $output1) {
//                    ForEach(Categories.allCases, id: \.self) { category in
//                        Text(category.rawValue.capitalized).tag(category)                    }
//                }
//                .pickerStyle(.menu)
//            }
//            ).groupBoxStyle(CardGroupBoxStyle())
//
//        }
//        .padding()
//    }
//}
//
//struct GroupBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupBoxView()
//    }
//}
//
////struct CardGroupBoxStyle: GroupBoxStyle {
////    func makeBody(configuration: Configuration) -> some View {
////        VStack(alignment: .leading) {
////            configuration.label
////            configuration.content
////        }
////        .padding()
////        .frame(maxWidth: .infinity, alignment: .leading)
////        .background(Color(.systemGroupedBackground))
////
////        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
////
////
////
////    }
////}
