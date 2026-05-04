//
//  String.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation
import SwiftUI
import WebKit

extension String {
    func trimWhiteSpace() -> String{
        let newValue = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return newValue
    }
    func isValidEmail() -> Bool {
        let testEmail = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return testEmail.evaluate(with: self)
    }
    func isValidPhoneNumber(pattern: String) -> Bool {
        return self.range(of: pattern ,options: .regularExpression) != nil
    }
    func isValidIBAN() -> Bool {
        let ibanRegex = #"^SA\d{22}$"#
//        let ibanRegex = #"^[A-Z]{2}\d{22}$"#
        let ibanTest = NSPredicate(format: "SELF MATCHES %@", ibanRegex)
        return ibanTest.evaluate(with: self)
    }

    func toDouble() -> Double {
        let cleanString = self.replacingOccurrences(of: ",", with: "")
        return Double(cleanString) ?? 0.0
    }
    func toFloat() -> Float {
        return Float(self) ?? 0.0
    }

    func toPrice() -> String {
        return String(format: "%.01f", self.toDouble()) + " " + appCurrency
    }
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    func toDay() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.date(from: self)
        return date
    }
    @available(iOS 13.0, *)
    func toTimeAgo() -> String {
        guard let date = self.toDate() else {return String()}
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
}

extension String {
    func convertArabicToEnglish() -> String {
        let arabicNumerals = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
        let englishNumerals = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        var convertedString = self
        
        for (index, arabicNumeral) in arabicNumerals.enumerated() {
            convertedString = convertedString.replacingOccurrences(of: arabicNumeral, with: englishNumerals[index])
        }
        
        return convertedString
    }
}
extension String {
    func onlyDigits() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
// TODO: Replace with your app's currency symbol or use a localized string key "app_currency".
var appCurrency: String = "currency_symbol".localized

extension String{
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    // validate name
    var isValidName: Bool {
        if(self.count>=2 && self.count<=30){
            return true
        }else{
            return false
        }
    }
    var isValidReason: Bool {
        if(self.count>=1 && self.count<=30){
            return true
        }else{
            return false
        }
    }
    
    // validate name
    var isValidAddress: Bool {
        if(self.count>=2 && self.count<=50){
            return true
        }else{
            return false
        }
    }
    
    // validate full name
    var validateFullName : Bool {
        let nameArray: [String] = self.split { $0 == " " }.map { String($0) }
        if nameArray.count >= 3 {
            return true
        }else{
            return false
        }
    }
    //Validate Phone
    
    func isValidPhone() -> Bool {
        if self.hasPrefix("1") && self.count <= 10 {
            return true
        } else {
            return false
        }
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func isPasswordConfirm(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
    
    //validate Password
    var isValidPassword: Bool {
        if(self.count >= 8 ){
            return true
        }else{
            return false
        }
    }
    
    
    func getDateAndTime() -> String {
        let full: String = self
        let fullDateArr = full.components(separatedBy:"T")
        let time: String = fullDateArr[1]
        let fullTimeArr = time.components(separatedBy:"Z")
        let timeFinal: String = fullTimeArr[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: timeFinal)
        guard let ConvertDate  = date else {return ""}
        let string  = dateFormatter.string(from: ConvertDate)
        
        return string
    }
    
    func getDateInFormYYYYMMDD() -> Date {
        let timeFinal: String = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: timeFinal) else { return Date() }
        return date
    }
    
    func getDateFromHHMMSS() -> Date {
        let timeFinal: String = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let date = dateFormatter.date(from: timeFinal) else { return Date() }
        return date
    }
    func convertTo24HourFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "HH:mm:ss"
            print(dateFormatter.string(from: date))
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    public var convertDigitsToEng : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8", "٩": "9"]
        var txt = self
        let _ = arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedText = try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding:String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.alignment = .right
            attributedText.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: paragraphStyle,
                range: NSMakeRange(0, attributedText.length)
            )
            return attributedText
        } catch {
            return nil
        }
    }
}


struct HTMLView: UIViewRepresentable {
    let html: String
    @Binding var dynamicHeight: CGFloat

    func makeUIView(context: Context) -> WKWebView {
        let wv = WKWebView()
        wv.navigationDelegate = context.coordinator
        
        wv.isOpaque = false
        wv.backgroundColor = .clear
        
        wv.scrollView.isScrollEnabled = false
        wv.scrollView.isOpaque = false
        wv.scrollView.backgroundColor = .clear
        
        wv.scrollView.subviews.forEach { $0.backgroundColor = .clear }

        return wv
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isOpaque = false
        webView.scrollView.backgroundColor = .clear

        let wrapped = """
        <html dir="rtl">
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
          <style>
            body {
              font-family: -apple-system;
              font-size: 14px;
              color: -apple-system-label;
              margin: 0;
              line-height: 1.7;
              text-align: right;
              background-color: transparent; /* مهم عشان ميبقاش رمادي */
            }
            p { margin: 0 0 12px 0; }
            strong { font-weight: 600; }
          </style>
        </head>
        <body>\(html)</body>
        </html>
        """
        webView.loadHTMLString(wrapped, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, WKNavigationDelegate {
        private let parent: HTMLView
        init(_ parent: HTMLView) { self.parent = parent }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.scrollHeight") { result, _ in
                if let h = result as? CGFloat {
                    DispatchQueue.main.async {
                        self.parent.dynamicHeight = ceil(h)
                    }
                } else if let n = result as? NSNumber {
                    DispatchQueue.main.async {
                        self.parent.dynamicHeight = ceil(CGFloat(truncating: n))
                    }
                }
            }
        }
    }
}
