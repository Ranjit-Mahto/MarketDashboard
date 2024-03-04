//
//  String+Extension.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 3/02/24.
//

import Foundation

extension String {
    
    var getRatingEmoji:String {
        if self.isEmpty != true {
            let emoji = String(UnicodeScalar(Int(self, radix: 16)!)!)
            return emoji
        }
        return ""
    }
    
    static func getEmojiRating(ratingEmoji:String?, ratingValue:Double) -> String {
        guard let emojiCode = ratingEmoji else {return ""}
        let emoji = String(UnicodeScalar(Int(emojiCode, radix: 16)!)!)
        return emoji + " " + String(ratingValue)
    }
    
    static func localCurreny(price:Int) -> String {
        let cur:Float = Float(price)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        return formatter.string(from: cur as NSNumber)!
    }
    
    static func crossedCurrency(price:Int) -> NSMutableAttributedString {
        let crossedPrice = String.localCurreny(price: price)
        let attributeString = NSMutableAttributedString(string: crossedPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
}
