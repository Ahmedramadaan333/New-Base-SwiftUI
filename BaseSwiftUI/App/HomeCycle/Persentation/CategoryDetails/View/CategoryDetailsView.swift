//
//  CategoryDetailsView.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026
//

import SwiftUI

struct CategoryDetailsView: View {

    let category: CategoryModel

    @State private var searchText: String = ""
    @State private var selectedSubCategoryID: Int?
    @State private var selectedLayout: AdsLayoutStyle = .list

    // MARK: - Dummy Data (replace with API data when it's ready)

    private let dummySubCategories: [CategoryModel] = [
        CategoryModel(id: 1, name: "أثاث", description: "", image: "https://picsum.photos/id/116/300/300"),
        CategoryModel(id: 2, name: "إلكترونيات", description: "", image: "https://picsum.photos/id/180/300/300"),
        CategoryModel(id: 3, name: "عقارات", description: "", image: "https://picsum.photos/id/1031/300/300"),
        CategoryModel(id: 4, name: "إلكترونيات", description: "", image: "https://picsum.photos/id/2/300/300"),
        CategoryModel(id: 5, name: "سيارات", description: "", image: "https://picsum.photos/id/111/300/300")
    ]

    private let dummyAds: [AdModel] = (1...3).map { index in
        AdModel(
            id: index,
            title: "كرسي للبيع بحالة جديدة",
            price: 200,
            date: "23/12/2024",
            sellerName: "سارة الشيخ",
            image: "https://picsum.photos/id/116/400/400",
            isFeatured: true
        )
    }

    private var filteredSubCategories: [CategoryModel] {
        guard !searchText.isEmpty else { return dummySubCategories }
        return dummySubCategories.filter { $0.name.contains(searchText) }
    }

    var body: some View {
        BaseView(title: category.name) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    searchBar

                    subCategoriesSection

                    layoutControlsBar

                    adsSection
                }
                .padding(.vertical, 8)
            }
        }
        .toolbarBackground(Color.primaryMain, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    // MARK: - Search

    private var searchBar: some View {
        HStack(spacing: 8) {
            TextField("search_section_placeholder".localized, text: $searchText)
                .font(AppFont.medium(size: 14))

            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundStyle(Color.placeholderText)
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackground)
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
        )
    }

    // MARK: - Sub Categories

    private var subCategoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("sections_title".localized)
                .font(AppFont.bold(size: 16))
                .foregroundStyle(Color.primary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(filteredSubCategories) { subCategory in
                        SubCategoryItemView(
                            subCategory: subCategory,
                            isSelected: selectedSubCategoryID == subCategory.id
                        ) {
                            selectedSubCategoryID = subCategory.id
                        }
                    }
                }
            }
        }
    }

    // MARK: - Layout Controls

    private var layoutControlsBar: some View {
        HStack(spacing: 8) {
            ForEach(AdsLayoutStyle.allCases, id: \.self) { layout in
                layoutToggleButton(layout)
            }

            Spacer()

            Button {
                // TODO: open filters
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.primaryMain)
                    .frame(width: 38, height: 38)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primaryMain.opacity(0.12))
                    )
            }
            .buttonStyle(.plain)
        }
    }

    private func layoutToggleButton(_ layout: AdsLayoutStyle) -> some View {
        let isSelected = selectedLayout == layout

        return Button {
            selectedLayout = layout
        } label: {
            Image(systemName: layout.icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(isSelected ? Color.primaryMain : Color.secondaryTextFont)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color.primaryMain.opacity(0.12) : Color.clear)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Ads

    @ViewBuilder
    private var adsSection: some View {
        switch selectedLayout {
        case .grid:
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible())], spacing: 12) {
                ForEach(dummyAds) { ad in
                    AdGridCardView(ad: ad)
                }
            }
        case .list, .map:
            LazyVStack(spacing: 14) {
                ForEach(dummyAds) { ad in
                    AdCardView(ad: ad)
                }
            }
        }
    }
}

// MARK: - Sub Category Item

private struct SubCategoryItemView: View {

    let subCategory: CategoryModel
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                RemoteImageView(url: subCategory.image)
                    .scaledToFill()
                    .frame(width: 70, height: 55)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.primaryMain : Color.clear, lineWidth: 2)
                    )

                Text(subCategory.name)
                    .font(AppFont.semiBold(size: 13))
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Ad Card (List)

private struct AdCardView: View {

    let ad: AdModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            RemoteImageView(url: ad.image)
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipped()
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 8) {
                Text(ad.title)
                    .font(AppFont.semiBold(size: 14))
                    .foregroundStyle(Color.primary)
                    .lineLimit(2)

                Text(ad.price.toPrice)
                    .font(AppFont.bold(size: 14))
                    .foregroundStyle(Color.secondaryMain)

                Text(ad.date)
                    .font(AppFont.medium(size: 12))
                    .foregroundStyle(Color.secondaryTextFont)
            }

            Spacer()

            VStack(alignment: .trailing) {
                if ad.isFeatured {
                    FeaturedBadgeView()
                }

                Spacer()

                Text(ad.sellerName)
                    .font(AppFont.semiBold(size: 13))
                    .foregroundStyle(Color.primaryMain)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .frame(height: 114)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
}

// MARK: - Ad Card (Grid)

private struct AdGridCardView: View {

    let ad: AdModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            RemoteImageView(url: ad.image)
                .scaledToFill()
                .frame(height: 110)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)
                .overlay(alignment: .topLeading) {
                    if ad.isFeatured {
                        FeaturedBadgeView()
                            .padding(6)
                    }
                }

            Text(ad.title)
                .font(AppFont.semiBold(size: 13))
                .foregroundStyle(Color.primary)
                .lineLimit(1)

            Text(ad.price.toPrice)
                .font(AppFont.bold(size: 13))
                .foregroundStyle(Color.secondaryMain)

            HStack {
                Text(ad.sellerName)
                    .font(AppFont.semiBold(size: 12))
                    .foregroundStyle(Color.primaryMain)

                Spacer()

                Text(ad.date)
                    .font(AppFont.medium(size: 11))
                    .foregroundStyle(Color.secondaryTextFont)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
}

// MARK: - Featured Badge

private struct FeaturedBadgeView: View {
    var body: some View {
        Text("featured_title".localized)
            .font(AppFont.semiBold(size: 11))
            .foregroundStyle(Color.secondaryMain)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(Color.cardBackground)
                    .overlay(
                        Capsule()
                            .stroke(Color.secondaryMain, lineWidth: 1)
                    )
            )
    }
}
