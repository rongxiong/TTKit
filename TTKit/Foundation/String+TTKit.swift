//
//  String+TTKit.swift
//  TTKit
//
//  Created by 陈荣雄 on 3/23/16.
//  Copyright © 2016 陈荣雄. All rights reserved.
//

import Foundation

extension String {
    func base64EncodedString() -> String? {
        guard !self.isEmpty else {
            return nil
        }
        return self.dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    
    func base64RawString() -> String? {
        let rawData = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        return String(data: rawData!, encoding: NSUTF8StringEncoding)
    }
    
    func escape() -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        let allowedCharacterSet = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacterSet.removeCharactersInString(generalDelimitersToEncode + subDelimitersToEncode)
        
        var escaped = ""
        
        //==========================================================================================================
        //
        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
        //  hundred Chinense characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
        //  info, please refer to:
        //
        //      - https://github.com/Alamofire/Alamofire/issues/206
        //
        //==========================================================================================================
        
        if #available(iOS 8.3, OSX 10.10, *) {
            escaped = self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? self
        } else {
            let batchSize = 50
            var index = self.startIndex
            
            while index != self.endIndex {
                let startIndex = index
                let endIndex = index.advancedBy(batchSize, limit: self.endIndex)
                let range = startIndex ..< endIndex//Range(start: startIndex, end: endIndex)
                
                let substring = self.substringWithRange(range)
                
                escaped += substring.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? substring
                
                index = endIndex
            }
        }
        
        return escaped
    }

}