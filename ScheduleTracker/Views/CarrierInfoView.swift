//
//  CarrierInfoView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 29.06.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: CarrierInfoViewModel
    let code: String
    
    var body: some View {
        ZStack {
            Color("nightOrDayColor").ignoresSafeArea()
            StateWrapperView(isLoading: viewModel.isLoading, errorType: viewModel.errorType) {
                Group {
                    if let carrier = viewModel.carrier {
                        VStack(spacing: 16) {
                            if let logo = carrier.logo, let url = URL(string: logo) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: 343, height: 104)
                                .clipped()
                            }
                            VStack(alignment: .leading, spacing: 16) {
                                Text(carrier.title)
                                    .font(.custom("SFPro-Bold", size: 24))
                                    .foregroundStyle(Color("dayOrNightColor"))
                                if let email = carrier.email {
                                    Text("E-mail")
                                        .font(.custom("SFPro-Regular", size: 16))
                                        .foregroundStyle(Color("dayOrNightColor"))
                                        .padding(.top, 12)
                                    if let mailURL = URL(string: "mailto:\(email)") {
                                        Link(email, destination: mailURL)
                                            .font(.custom("SFPro-Regular", size: 16))
                                            .foregroundColor(.blue)
                                            .padding(.bottom, 12)
                                    }
                                }
                                if let phone = carrier.phone {
                                    Text("Телефон")
                                        .font(.custom("SFPro-Regular", size: 16))
                                        .foregroundStyle(Color("dayOrNightColor"))
                                        .padding(.top, 12)
                                    if let telURL = URL(string: "tel:\(phone.onlyDigits())") {
                                        Link(phone, destination: telURL)
                                            .font(.custom("SFPro-Regular", size: 16))
                                            .foregroundColor(.blue)
                                            .padding(.bottom, 12)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("leftChevron")
                        .renderingMode(.template)
                        .foregroundStyle(Color("dayOrNightColor"))
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.custom("SFPro-Bold", size: 17))
                    .foregroundStyle(Color("dayOrNightColor"))
            }
        }
        .task {
            await viewModel.fetchCarrier(code: code)
        }
    }
}

extension String {
    func onlyDigits() -> String {
        filter { $0.isNumber }
    }
}
