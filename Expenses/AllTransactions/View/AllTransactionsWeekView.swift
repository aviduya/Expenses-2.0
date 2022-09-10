//
//  AllTransactionsWeekView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 9/10/22.
//

import SwiftUI
import Charts

struct AllTransactionsWeekView: View {
    
    @StateObject var viewModel = AllTransactionsWeekViewModel()
    
    @State private var selectedDay = Calendar.current.startOfDay(for: Date())
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.TransactionsList) { date in
                        VStack {
                            Text(date.dayName)
                                .font(.footnote)
                            Text(date.dayNumber)
                                .foregroundColor(.white.opacity(selectedDay == date.savedDate ? 1 : 0.33))
                                .padding(10)
                                .background(selectedDay == date.savedDate ? Circle()
                                    .foregroundColor(.themeThree)
                                    .frame(width: 30, height: 30, alignment: .center)
                                            : nil)
                                .onTapGesture {
                                    withAnimation {
                                        selectedDay = date.savedDate
                                    }
                                }
                        }
                    }
                }
            }
            .padding(10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
        }
        
        TabView(selection: $selectedDay) {
            ForEach(viewModel.TransactionsList) { date in
                VStack {
                    if date.entities.isEmpty {
                        EmptyView(message: "Please add a Transaction")
                    } else {
                        ScrollView {
                            GroupBox("This day's transaction") {
                                Chart(date.entities) { transaction in
                                    BarMark(
                                        x: .value("Day", transaction.date ?? Date(), unit: .hour),
                                        y: .value("Amount", transaction.amount)
                                        
                                    )
                                    .cornerRadius(16)
                                    .foregroundStyle(.linearGradient(colors: [.themeOne, .themeTwo, .themeThree, .themeFour], startPoint: .bottom, endPoint: .top))
                                }
                            }
                            .frame(height: 300)
                            .padding(.vertical)
                            ForEach(date.entities) { transaction in
                                RowView(
                                    item: transaction.name ?? "",
                                    date: transaction.date ?? Date(),
                                    amount: transaction.amount,
                                    category: transaction.category ?? "")
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

// MARK: View Actions
extension AllTransactionsWeekView {
    
    
    func returStartOfDay(_ date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    
}
