//
//  GeneralPickerField.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 29/07/2025.
//

import SwiftUI

struct GeneralPickerField<Item: GeneralPickerModel & Equatable>: View {
    let title: String
    let placeholder: String
    let items: [Item]
    
    @Binding var selectedItem: Item?
    @Binding var forceValidate: Bool
    let height: CGFloat
    let radius: CGFloat
    let hasError: Bool
    let errorMessage: String
    let leadingImage: Image?
    let trailingImage: Image?
    
    @State private var showSheet = false
    @State private var displayedText: String = ""
    @State private var internalSelection: Item? = nil
    @FocusState private var isFocused: Bool
    
    private var borderColor: Color {
        if hasError {
            return .red
        } else if !displayedText.isEmpty && !hasError && !isFocused {
            return .primaryMain
        } else {
            return .gray
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .font(AppFont.medium(size: 16))
                Spacer()
            }
            
            HStack(spacing: 8) {
                if let leadingImage {
                    leadingImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                Text(displayedText.isEmpty ? placeholder : displayedText)
                    .font(AppFont.regular(size: 12))

                    .foregroundColor(displayedText.isEmpty ? .gray : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let trailingImage {
                    trailingImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                } else {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .frame(height: height)
            .background(Color.cardBackground)
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderColor, lineWidth: 0.5)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                showSheet.toggle()
            }
            
            if hasError {
                HStack {
                    Text(errorMessage)
                        .font(AppFont.regular(size: 12))
                        .minimumScaleFactor(0.9)
                        .padding(.leading, 5)
                        .foregroundStyle(Color.red)

                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            PickerSheetView(title: title, items: items, selected: $internalSelection)
        }
        .onChange(of: internalSelection) { newValue in
            selectedItem = newValue
            displayedText = newValue?.pickerTitle ?? ""
            if selectedItem != nil {
                forceValidate = false
            }
        }
    }
    
    init(
        title: String,
        placeholder: String,
        items: [Item],
        selectedItem: Binding<Item?>,
        forceValidate: Binding<Bool>,
        hasError: Bool,
        errorMessage: String = "",
        height: CGFloat = 50,
        radius: CGFloat = 16,
        leadingImage: Image? = nil,
        trailingImage: Image? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        self.items = items
        self._selectedItem = selectedItem
        self._forceValidate = forceValidate
        self.hasError = hasError
        self.errorMessage = errorMessage
        self.height = height
        self.radius = radius
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self._internalSelection = State(initialValue: selectedItem.wrappedValue)
        self._displayedText = State(initialValue: selectedItem.wrappedValue?.pickerTitle ?? "")
    }
}


struct GeneralPickerField_Previews: PreviewProvider {
    @State static var selectedCity: City? = nil
    @State static var forceValidate = true
    @State static var hasError = true
    
    static var previews: some View {
        GeneralPickerField(
            title: "City",
            placeholder: "Choose a city",
            items: [
                City(pickerId: 1, pickerTitle: "Cairo"),
                City(pickerId: 2, pickerTitle: "Alexandria"),
                City(pickerId: 3, pickerTitle: "Aswan")
            ],
            selectedItem: $selectedCity,
            forceValidate: $forceValidate,
            hasError: hasError,
            errorMessage: "City is required"
        )
        .padding()
    }
}
struct City: GeneralPickerModel {
    let pickerId: Int
    let pickerTitle: String
    let pickerImage: String? = nil
    let pickerSlug: String? = nil
}
