//
//  UIFont+.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit

extension UIFont {
    // MARK: - NotoSansKR
    public enum NotoSansKRType{
        case bold
        case regular
        case medium
        
        var name: String {
            switch self {
            case .bold:
                return "NotoSansKR-Bold"
            case .regular:
                return "NotoSansKR-Regular"
            case .medium:
                return "NotoSansKR-Medium"
            }
        }
    }
    
    static func notoSansKR(_ type: NotoSansKRType, size: CGFloat) -> UIFont {
        return UIFont(name: type.name, size: size)!
    }
    
    public enum NanumGothicType {
        case regular
        
        var name: String {
            switch self {
            case .regular:
                return "NanumGothic"
            }
        }
    }
    
    static func nanumGothic(_ type: NanumGothicType, size: CGFloat) -> UIFont {
        return UIFont(name: type.name, size: size)!
    }
}
