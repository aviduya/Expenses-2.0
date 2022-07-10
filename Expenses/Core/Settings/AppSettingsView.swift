//
//  AppSettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 5/4/22.
//

import SwiftUI
import Sentry


struct AppSettingsView: View {
    
    @EnvironmentObject var settings: AppSettings
    @Environment(\.dismiss) var dismiss
    @AppStorage(Keys.threshold.rawValue) var setThreshold: Double = 0.0
    
    @State private var bank: String = ""
    @State private var category: String  = ""
    
    @State private var subject: String = ""
    @State private var comment: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var type: FeedbackType = .bug
    
    let material: Material = .thin
    
    private var regularT: Double {
        return setThreshold
    }
    
    private var thresholdStart: Double {
        let t = setThreshold
        return  t / 3
    }
    
    private var thresholdEnd: Double {
        let t = setThreshold
        return t / 2
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        subject = ""
        comment = ""
        name = ""
        email = ""
        type = .bug
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Image(systemName: "building.columns")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                            Divider()
                            bankList
                        }
                        HStack {
                            Image(systemName: "checklist")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                            Divider()
                            categoryList
                        }
                        
                        HStack {
                            Image(systemName: "slider.horizontal.below.rectangle")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.teal)
                            Divider()
                            threshold
                            
                        }
                        
                        HStack  {
                            Image(systemName: "waveform.path.ecg")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                            Divider()
                            feedback
                        }
                        
                    } header: {
                        Text("Primary Settings")
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

extension AppSettingsView {
    var bankList: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        TextField("Add a Bank", text: $bank)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                settings.addElement(new: bank, element: &settings.banks, key: settings.bankKey)
                                bank = ""
                            }
                            .disabled(bank.isEmpty)
                    }
                    
                } footer: {
                    Text("A list of accounts that are displayed when adding a transaction.")
                }
                
                Section {
                    ForEach(settings.banks, id: \.self) { i in
                        Text(i)
                    }
                    .onDelete(perform: settings.removeBank)
                } header: {
                    HStack {
                        Image(systemName: "building.columns")
                            .foregroundColor(.orange)
                        Text("Active Accounts")
                    }
                }
                
            }
        } label: {
            Text("Banks")
        }
    }
    
    var categoryList: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        TextField("Enter a Category", text: $category)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                settings.addElement(new: category, element: &settings.categories, key: settings.categoryKey)
                                category = ""
                            }
                            .disabled(category.isEmpty)
                    }
                    
                } footer: {
                    Text("A list of category that is associated with the transaction.")
                }
                
                Section {
                    ForEach(settings.categories, id: \.self) { i in
                        HStack {
                            Text(i)
                            Spacer()
                        }
                    }
                    .onDelete(perform: settings.removeCategory)
                } header: {
                    HStack {
                        Image(systemName: "checklist")
                            .foregroundColor(.green)
                        Text("Active Categories")
                    }
                    
                }
                
            }
        } label: {
            Text("Categories")
        }
    }
    
    var threshold: some View {
        NavigationLink {
            VStack {
                
                Text("$\(setThreshold, specifier: "%.2f")")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                
                
                Divider()
                
                Section {
                    HStack{
                        TextField  ("", value: $setThreshold, format: .currency(code: "usd"))
                        Spacer()
                    }
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 16))
                } header: {
                    
                    HStack {
                        Text("Set Amount threshold.")
                            .font(.subheadline)
                            .opacity(0.33)
                        Spacer()
                    }
                    
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("$\(thresholdStart, specifier: "%.2f")")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .frame(width: 150, height: 100, alignment: .center)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(LinearGradient(colors: [.primaryGreen, .secondaryGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                            Spacer()
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.backward")
                                Text("Less Than")
                            }
                            .font(.title2)
                            
                            
                            
                        }
                        HStack {
                            
                            Text("$\(thresholdEnd, specifier: "%.2f")")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .frame(width: 150, height: 100, alignment: .center)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(LinearGradient(colors: [.primaryOrange, .secondaryOrange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                            Spacer()
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.left.arrow.right")
                                Text("Range of")
                            }
                            .font(.title2)
                        }
                        HStack {
                            
                            Text("$\(regularT, specifier: "%.2f")")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .frame(width: 150, height: 100, alignment: .center)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(LinearGradient(colors: [.primaryRed, .secondaryRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            
                                )
                            
                            Spacer()
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                Text("Greater than")
                            }
                            .font(.title2)
                        }
                        
                    }
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 16))
                } footer: {
                    HStack {
                        Text("These colors computes the amount that was set to three tiers of spending amount. Good, Warning and Extreme to the amount that is set .")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                            .opacity(0.33)
                        Spacer()
                    }
                }
            }.padding()
        } label: {
            Text("Threshold")
        }
    }
    
    var feedback: some View {
        NavigationLink {
            VStack(alignment: .leading) {
                Picker("", selection: $type) {
                    ForEach(FeedbackType.allCases, id: \.self) { t in
                        Text(t.id)
                            .bold()
        
                        
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)
                Section {
                    
                    TextField("Subject", text: $subject)
                        .padding()
                        .background(material, in: RoundedRectangle(cornerRadius: 16))
                    TextField("Name", text: $name)
                        .padding()
                        .background(material, in: RoundedRectangle(cornerRadius: 16))
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(material, in: RoundedRectangle(cornerRadius: 16))
                    
                    
                    
                } header: {
                    Text("Information")
                        .bold()
                        .opacity(0.33)
                }
                
               Divider()
                
                Section {
                    TextEditor(text: $comment)
                        .frame(maxHeight: 100)
                        .padding()
                        .background(material, in: RoundedRectangle(cornerRadius: 16))
                } header: {
                    Text("Additional Comments")
                        .bold()
                        .opacity(0.33)
                }
                
                Spacer()
                
                Button {
                    
                    let eventId = SentrySDK.capture(message: "[\(type.rawValue.capitalized)] \(subject)")
                    
                    let userFeedback = UserFeedback(eventId: eventId)
                    userFeedback.comments = comment
                    userFeedback.email = email
                    userFeedback.name = name
                    SentrySDK.capture(userFeedback: userFeedback)
                   
                    
                } label: {
                    HStack {
                        Text("Send")
                        Image(systemName: "paperplane")
                    }
                    .font(Font.system(size: 24, weight: .bold, design: .default))
                    
                }
                .buttonStyle(CustomButtonStyle())
                
            }
            .navigationTitle("Submit Feedback")
            .padding()
        } label: {
            Text("Feedback")
        }
    }
    
}
