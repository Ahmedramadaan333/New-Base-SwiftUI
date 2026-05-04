//
//  PickerSheetView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 29/07/2025.
//
import SwiftUI

struct PickerSheetView<Item: GeneralPickerModel>: View {
    let title: String
    let items: [Item]
    @Binding var selected: Item?

    @Environment(\.dismiss) private var dismiss
    @State private var tempSelection: Item?
    @State private var showError: Bool = false
    @State private var searchText: String = ""

    private var filteredItems: [Item] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return items }
        return items.filter { $0.pickerTitle.localizedCaseInsensitiveContains(q) }
    }

    var body: some View {
        VStack(spacing: 8) {

            Text(title)
                .font(AppFont.semiBold(size: 16))
                .padding(8)

            TextField("Search...".localized, text: $searchText)
                .font(AppFont.regular(size: 14))
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

            Divider()
                .padding(.top, 16)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredItems, id: \.pickerId) { item in
                        HStack(spacing: 12) {
                            Image(systemName: tempSelection?.pickerId == item.pickerId ? "largecircle.fill.circle" : "circle")
                                .foregroundColor(Color(.primaryMain))
                                .font(AppFont.regular(size: 14))

                            Text(item.pickerTitle)                                .font(AppFont.medium(size: 14))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal)
                        .frame(height: 50)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            tempSelection = item
                            showError = false
                        }

                        Divider()
                    }
                }
                .padding(.top, 8)
            }

            if showError {
                Text("select_error_message".localized)
                    .foregroundColor(.red)
                    .font(AppFont.semiBold(size: 14))
                    .padding(.top, 4)
            }

            Spacer()

            Button {
                if let selectedValue = tempSelection {
                    selected = selectedValue
                    dismiss()
                } else {
                    showError = true
                }
            } label: {
                Text("confirm_title".localized)
                    .font(AppFont.semiBold(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(.primaryMain))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
            }
            .padding(.vertical, 12)
        }
        .onAppear {
            tempSelection = selected
        }
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .presentationDetents( [.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

