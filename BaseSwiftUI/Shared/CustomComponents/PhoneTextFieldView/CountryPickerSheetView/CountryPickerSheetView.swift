//
//  CountryPickerSheetView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 30/07/2025.
//

import SwiftUI
import Kingfisher

struct CountryPickerSheetView<Item: CountryCodeModel>: View {
    let title: String
    let items: [Item]
    @Binding var selected: Item?

    @Environment(\.dismiss) private var dismiss
    @State private var internalSelection: Item?
    @State private var showError = false
    @State private var searchText: String = ""

    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter {
                $0.countryName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(AppFont.semiBold(size: 16))
                .padding(.top, 16)

            TextField("Search...".localized, text: $searchText)
                .font(AppFont.regular(size: 14))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)

            Divider()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredItems) { item in
                        HStack(spacing: 12) {
                            KFImage(URL(string: item.image ?? ""))
                                .placeholder {
                                    Image(.logo)
                                        .resizable()
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 20)
                                .cornerRadius(4)

                            Text("\(item.countryName) \(item.countryCode ?? "")")
                                .foregroundColor(.primary)
                                .font(AppFont.regular(size: 14))
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if internalSelection?.pickerId == item.pickerId {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.primaryMain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 44)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            internalSelection = item
                        }

                        Divider()
                    }
                }
            }

            Button(action: {
                if let confirmed = internalSelection {
                    selected = confirmed
                    dismiss()
                } else {
                    showError = true
                }
            }) {
                Text("confirm_title".localized)
                    .font(AppFont.semiBold(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(.primaryMain))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
        }
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .presentationDetents([ .medium, .large])
        .presentationDragIndicator(.visible)
        .alert("Please select a country".localized, isPresented: $showError) {
            Button("OK".localized, role: .cancel) {}
        }
        .onAppear {
            internalSelection = selected
        }
    }
        
}



