//
//  DetectableHTMLText.swift
//  CTF
//
//  Created by Ahmed Ramadan on 27/11/2025.
//

import SwiftUI

extension String {
    /// HTML -> NSAttributedString مع paragraph style
    var htmlToNSAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedText = try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.alignment = .right
            paragraphStyle.lineSpacing = 4

            attributedText.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: NSMakeRange(0, attributedText.length)
            )

            return attributedText
        } catch {
            print("html error:", error)
            return nil
        }
    }

    /// HTML -> AttributedString (SwiftUI) + link & phone detection
    var htmlToDetectedSwiftUIAttributedString: AttributedString? {
        guard let mutable = htmlToNSAttributedString else { return nil }

        let fullRange = NSRange(location: 0, length: (mutable.string as NSString).length)

        let types: NSTextCheckingResult.CheckingType = [.link, .phoneNumber]

        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return AttributedString(mutable)
        }

        detector.enumerateMatches(in: mutable.string, options: [], range: fullRange) { match, _, _ in
            guard let match = match else { return }

            switch match.resultType {
            case .link:
                if let url = match.url {
                    mutable.addAttribute(.link, value: url, range: match.range)
                }
            case .phoneNumber:
                if let number = match.phoneNumber {
                    let clean = number.replacingOccurrences(of: " ", with: "")
                    if let url = URL(string: "tel://\(clean)") {
                        mutable.addAttribute(.link, value: url, range: match.range)
                    }
                }
            default:
                break
            }
        }

        return AttributedString(mutable)
    }
}
struct HTMLText: View {
    let html: String

    var body: some View {
        if let attributed = html.htmlToDetectedSwiftUIAttributedString {
            Text(attributed)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .tint(.blue)
                .font(AppFont.regular(size: 14))
        } else {
            Text(html)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(AppFont.regular(size: 14))

        }
    }
    
}

