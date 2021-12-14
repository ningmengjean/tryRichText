//
//  Extensions-String.swift
//  tryRichText
//
//  Created by 朱晓瑾 on 2021/12/14.
//

import Foundation
import DTCoreText

extension String {
    //Use of DTCoreText library to convert html to String.
        public func returnAttributedStringForHTMLString (fontFamily: String, fontName: String, fontSize: CGFloat, textColor: UIColor, textAlignment: CTTextAlignment) -> NSMutableAttributedString {
            let encodedData = self.data(using: String.Encoding.utf8)!
            let options = [
                DTDefaultFontFamily:fontFamily,
                DTDefaultFontName: fontName,
                DTDefaultFontSize: fontSize,
                DTDefaultTextColor: textColor,
                DTDefaultTextAlignment: NSNumber(value: textAlignment.rawValue)
                ] as [String : Any]
            let builder = DTHTMLAttributedStringBuilder(html: encodedData, options: options, documentAttributes: nil)
            var returnValue:NSAttributedString?
            returnValue = builder?.generatedAttributedString()
            if returnValue != nil {
                //needed to show link highlighting
                let mutable = NSMutableAttributedString(attributedString: returnValue!)
                mutable.removeAttribute(NSAttributedString.Key.foregroundColor, range: NSMakeRange(0, mutable.length))
                return mutable
            }else{
                return NSMutableAttributedString(string: "")
            }
        }
    
    func convert(fromHTML htmlString: String) -> NSAttributedString? {
            guard let data = htmlString.data(using: .utf8,
                                             allowLossyConversion: true) else {
                return nil
            }
            
            guard let temp = DTHTMLAttributedStringBuilder(html: data,
                                                           options: nil,
                                                           documentAttributes: nil) else {
                return nil
            }
            return temp.generatedAttributedString()
        }
    
}
