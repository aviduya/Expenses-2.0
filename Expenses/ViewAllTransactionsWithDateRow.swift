//
//  ViewAllTransactionsWithDateRow.swift
//  Expenses
//
//  Created by Anfernee Viduya on 9/9/22.
//

import SwiftUI
import Charts

struct ViewAllTransactionsWithDateRowModel: Identifiable {
    let id = UUID().uuidString
    var dayName: String
    var dayNumber: String
    var savedDate: Date
    var entities: [TransactionEntity]
    
    init(dayName: String, dayNumber: String, savedDate: Date, entities: [TransactionEntity]) {
        
        self.dayName = dayName
        self.dayNumber = dayNumber
        self.savedDate = Calendar.current.startOfDay(for: savedDate)
        self.entities = entities
    }
}

class ViewAllTransactionsWithDateRowViewModel: ObservableObject {
    
    let dataManager: CoreDataHandler = .shared
    @Published var TransactionsList: [ViewAllTransactionsWithDateRowModel] = []
    
    init() {
        doThatStuff()
    }
    
    func doThatStuff() {
        
        let calendar = Calendar.current
        
        let dateNow = calendar.startOfDay(for: Date.now)
        
        let nameDateFormatter = DateFormatter()
        let dayDateFormatter = DateFormatter()
        nameDateFormatter.dateFormat = "EEEE"
        dayDateFormatter.dateFormat = "d"
        
        var days: [Date] = []
        
        for x in 0...7 {
            days.append(calendar.date(byAdding: .day, value: -x, to: dateNow) ?? Date())
        }
        
        for day in days {
            TransactionsList.append(
                ViewAllTransactionsWithDateRowModel(dayName: nameDateFormatter.string(from: day), dayNumber: dayDateFormatter.string(from: day), savedDate: day, entities: dataManager.getRangeOfTransactionsExample(start: calendar.startOfDay(for: day), end: calendar.date(bySettingHour: 23, minute: 59, second: 59, of: day) ?? Date())))
        }
        
        
    }

    
}
struct ViewAllTransactionsWithDateRow: View {
    
    @StateObject var vm = ViewAllTransactionsWithDateRowViewModel()
    
    @State var selectedTab = Calendar.current.startOfDay(for: Date())
    
    func returnStartOfDay(date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    var body: some View {
        VStack {
            Text("All Transactions")
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 30) {
                    ForEach(vm.TransactionsList) { expense in
                        VStack {
                            Text(String(expense.dayName.first ?? "E"))
                                .font(.title3)
                            Text(expense.dayNumber)
                                .padding(10)
                                .background(selectedTab == expense.savedDate ? Circle().foregroundColor(.themeThree) : nil)
                                .onTapGesture {
                                    withAnimation {
                                        selectedTab = expense.savedDate
                                        print(selectedTab)
                                    }
                                    
                                }
                        }
                    }
                    
                }
                
                
            }
            .padding(10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
        }
    TabView(selection: $selectedTab) {
        ForEach(vm.TransactionsList) { date in
            
            VStack {
                if date.entities.isEmpty {
                    Text("\(date.savedDate)")
                    EmptyView(message: "This will show the record")
                } else {
                    
                    Spacer()
                    
                    GroupBox("Today's Transactions") {
                        Chart(date.entities) { transaction in
                            
                            

                            BarMark(
                                x: .value("Day", transaction.date ?? Date(), unit: .hour),
                                y: .value("Amount", transaction.amount)
                            )

                            .foregroundStyle(.linearGradient(colors: [.themeOne, .themeTwo, .themeThree, .themeFour], startPoint: .bottom, endPoint: .top))
                            
                        }
                    }
                    .padding(.vertical)
                   
                    Spacer()
                        ScrollView {
                            ForEach(date.entities) { transaction in
                                RowView(item: transaction.name ?? "", date: transaction.date ?? Date(), amount: transaction.amount, category: transaction.category ?? "")
                            }
                        }
                }
                
            }
            .tag(date.savedDate)
        }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

}

