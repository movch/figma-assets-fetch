import Foundation

@objc
public enum ThemeColor: Int {

    case Text / Primary

    case Text / Inverted

    case Text / Secondary

    case Text / Placeholder

    case Text / Tertiary

    case Text / Disabled

    case Input / Normal

    case Skeleton / Primary bg

    case Skeleton / Secondary bg

    case Controls / Secondary

    case Controls / Primary

    case Controls / Secondary Disabled

    case Controls / Unchecked Light

    case Border / Primary

    case Border / Secondary

    case Input / Active

    case Icon / Dark Primary

    case Icon / Inverted Primary

    case Skeleton / Primary gradient

    case Skeleton / Secondary gradient

    case Input / Negative

    case Input / Positive

    case Bg / Primary

    case Bg / Secondary

    case Bg / Tertiary

    case Text / Brand

    case Text / Starred

    case Bg / Brand Primary

    case Bg / Negative Primary

    case Button / Negative Solid

    case Icon / Negative Primary

    case Button / Negative Secondary

    case Text / Yellow Primary

    case Text / Yellow Secondary

    case Text / Yellow Tertiary

    case Text / Yellow Disabled

    case Text / Yellow Link

    case Text / Yellow Colored

    case Text / Blue Primary

    case Text / Blue Secondary

    case Text / Blue Tertiary 

    case Text / Blue Disabled

    case Text / Blue Link

    case Text / Blue Colored

    case Text / Positive Primary

    case Text / Negative Primary

    case Text / Warning Primary

    case Text / Positive Secondary

    case Text / Negative Secondary

    case Text / Warning Secondary

    case Text / Positive Tertiary

    case Text / Negative Tertiary

    case Text / Warning Tertiary

    case Text / Positive Disabled

    case Text / Negative Disabled

    case Text / Warning Disabled

    case Text / Positive Link

    case Text / Negative Link

    case Text / Warning Link

    case Text / Positive Colored

    case Text / Negative Colored

    case Text / Warning Colored

    case Text / Red Primary

    case Text / Pink Primary

    case Text / Red Secondary

    case Text / Pink Secondary

    case Text / Red Tertiary

    case Text / Pink Tertiary

    case Text / Red Disabled

    case Text / Pink Disabled

    case Text / Red Link

    case Text / Pink Link

    case Text / Red Colored

    case Text / Pink Colored

    case Bg / Blue Primary

    case Button / Blue Primary

    case Icon / Blue Primary

    case Button / Blue Secondary

    case Bg / Warning Primary

    case Button / Warning Primary

    case Icon / Warning Primary

    case Button / Warning Secondary

    case Button / Inverted Primary

    case Button / Secondary

    case Button / Brand Primary

    case Icon / Brand Primary

    case Button / Brand Secondary

    case Bg / Red Primary

    case Button / Red Primary

    case Icon / Red Primary

    case Button / Red Secondary

    case Bg / Salad Primary

    case Button / Salad Primary

    case Icon / Salad Primary

    case Button / Salad Secondary

    case Bg / Violet Primary

    case Button / Violet Primary

    case Icon / Violet Primary

    case Button / Violet Secondary

    case Bg / Yellow Primary

    case Button / Yellow Primary

    case Icon / Yellow Primary

    case Button / Yellow Secondary

    case Bg / Pink Primary

    case Button / Pink Primary

    case Icon / Pink Primary

    case Button / Pink Secondary

    case Bg / Mint Primary

    case Button / Mint Primary

    case Icon / Mint Primary

    case Button / Mint Secondary

    case Bg / Orange Primary

    case Button / Orange Primary

    case Icon / Orange Primary

    case Button / Orange Secondary

    case Text / Salad Primary

    case Text / Mint Primary

    case Text / Salad Secondary

    case Text / Mint Secondary

    case Text / Salad Tertiary

    case Text / Mint Tertiary

    case Text / Salad Disabled

    case Text / Mint Disabled

    case Text / Salad Link

    case Text / Mint Link

    case Text / Salad Colored

    case Text / Mint Colored

    case Text / Violet Primary

    case Text / Violet Secondary

    case Text / Violet Tertiary

    case Text / Violet Disabled

    case Text / Violet Link

    case Text / Violet Colored

    case Text / Orange Primary

    case Text / Orange Secondary

    case Text / Orange Tertiary

    case Text / Orange Disabled

    case Text / Orange Link

    case Text / Orange Colored

    case Bg / Positive Primary

    case Button / Positive Primary

    case Icon / Positive Primary

    case Button / Positive Secondary

    case Bg / Brand Secondary

    case Bg / Negative Secondary

    case Bg / Negative Solid

    case Bg / Blue Secondary

    case Bg / Warning Secondary

    case Bg / Warning Solid

    case Bg / Red Secondary

    case Bg / Salad Secondary

    case Bg / Violet Secondary

    case Bg / Yellow Secondary

    case Bg / Pink Secondary

    case Bg / Mint Secondary

    case Bg / Orange Secondary

    case Bg / Positive Secondary

    case Bg / Positive Solid

    case Bg / Brand Solid

    case Bg / Blue Solid

    case Bg / Red Solid

    case Bg / Salad Solid

    case Bg / Violet Solid

    case Bg / Yellow Solid

    case Bg / Pink Solid

    case Bg / Mint Solid

    case Bg / Orange Solid

    case Bg / Promo Solid

    case Bg / Fullpage Tint

    case Bg / Toast

    case Icon / Yellow Primary2

    case Icon / Pink Primary2

    case Icon / Red Primary2

}

public func color(_ color: ThemeColor) -> UIColor {
    switch color {
    
    case .Text / Primary:
        return UIColor(hexNum: 0x04121B, alpha: 1.0)
    
    case .Text / Inverted:
        return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
    
    case .Text / Secondary:
        return UIColor(hexNum: 0x04121B, alpha: 0.6399999856948853)
    
    case .Text / Placeholder:
        return UIColor(hexNum: 0x04121B, alpha: 0.36000001430511475)
    
    case .Text / Tertiary:
        return UIColor(hexNum: 0x04121B, alpha: 0.47999998927116394)
    
    case .Text / Disabled:
        return UIColor(hexNum: 0x04121B, alpha: 0.23999999463558197)
    
    case .Input / Normal:
        return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
    
    case .Skeleton / Primary bg:
        return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
    
    case .Skeleton / Secondary bg:
        return UIColor(hexNum: 0xEEEEEE, alpha: 1.0)
    
    case .Controls / Secondary:
        return UIColor(hexNum: 0xCBCDCF, alpha: 1.0)
    
    case .Controls / Primary:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Controls / Secondary Disabled:
        return UIColor(hexNum: 0xE9EAEB, alpha: 1.0)
    
    case .Controls / Unchecked Light:
        return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
    
    case .Border / Primary:
        return UIColor(hexNum: 0x242D34, alpha: 0.10000000149011612)
    
    case .Border / Secondary:
        return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
    
    case .Input / Active:
        return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
    
    case .Icon / Dark Primary:
        return UIColor(hexNum: 0x04121B, alpha: 0.47999998927116394)
    
    case .Icon / Inverted Primary:
        return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
    
    case .Skeleton / Primary gradient:
        return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
    
    case .Skeleton / Secondary gradient:
        return UIColor(hexNum: 0xF9F9F9, alpha: 1.0)
    
    case .Input / Negative:
        return UIColor(hexNum: 0xFFEBED, alpha: 1.0)
    
    case .Input / Positive:
        return UIColor(hexNum: 0xDBFFDE, alpha: 1.0)
    
    case .Bg / Primary:
        return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
    
    case .Bg / Secondary:
        return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
    
    case .Bg / Tertiary:
        return UIColor(hexNum: 0xE9ECED, alpha: 1.0)
    
    case .Text / Brand:
        return UIColor(hexNum: 0x00A6F0, alpha: 1.0)
    
    case .Text / Starred:
        return UIColor(hexNum: 0xFFC71D, alpha: 1.0)
    
    case .Bg / Brand Primary:
        return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
    
    case .Bg / Negative Primary:
        return UIColor(hexNum: 0xFFEBED, alpha: 1.0)
    
    case .Button / Negative Solid:
        return UIColor(hexNum: 0xFF7581, alpha: 1.0)
    
    case .Icon / Negative Primary:
        return UIColor(hexNum: 0xFF7581, alpha: 1.0)
    
    case .Button / Negative Secondary:
        return UIColor(hexNum: 0xFFF0F1, alpha: 1.0)
    
    case .Text / Yellow Primary:
        return UIColor(hexNum: 0x271907, alpha: 1.0)
    
    case .Text / Yellow Secondary:
        return UIColor(hexNum: 0x271907, alpha: 0.6399999856948853)
    
    case .Text / Yellow Tertiary:
        return UIColor(hexNum: 0x271907, alpha: 0.47999998927116394)
    
    case .Text / Yellow Disabled:
        return UIColor(hexNum: 0x271907, alpha: 0.23999999463558197)
    
    case .Text / Yellow Link:
        return UIColor(hexNum: 0xC08114, alpha: 1.0)
    
    case .Text / Yellow Colored:
        return UIColor(hexNum: 0x926100, alpha: 1.0)
    
    case .Text / Blue Primary:
        return UIColor(hexNum: 0x091E2A, alpha: 1.0)
    
    case .Text / Blue Secondary:
        return UIColor(hexNum: 0x091E2A, alpha: 0.6399999856948853)
    
    case .Text / Blue Tertiary :
        return UIColor(hexNum: 0x091E2A, alpha: 0.47999998927116394)
    
    case .Text / Blue Disabled:
        return UIColor(hexNum: 0x091E2A, alpha: 0.23999999463558197)
    
    case .Text / Blue Link:
        return UIColor(hexNum: 0x1797CC, alpha: 1.0)
    
    case .Text / Blue Colored:
        return UIColor(hexNum: 0x0070AB, alpha: 1.0)
    
    case .Text / Positive Primary:
        return UIColor(hexNum: 0x062108, alpha: 1.0)
    
    case .Text / Negative Primary:
        return UIColor(hexNum: 0x2E0509, alpha: 1.0)
    
    case .Text / Warning Primary:
        return UIColor(hexNum: 0x2B1707, alpha: 1.0)
    
    case .Text / Positive Secondary:
        return UIColor(hexNum: 0x062108, alpha: 0.6399999856948853)
    
    case .Text / Negative Secondary:
        return UIColor(hexNum: 0x2E0509, alpha: 0.6399999856948853)
    
    case .Text / Warning Secondary:
        return UIColor(hexNum: 0x2B1707, alpha: 0.6399999856948853)
    
    case .Text / Positive Tertiary:
        return UIColor(hexNum: 0x062108, alpha: 0.47999998927116394)
    
    case .Text / Negative Tertiary:
        return UIColor(hexNum: 0x2E0509, alpha: 0.47999998927116394)
    
    case .Text / Warning Tertiary:
        return UIColor(hexNum: 0x2B1707, alpha: 0.47999998927116394)
    
    case .Text / Positive Disabled:
        return UIColor(hexNum: 0x062108, alpha: 0.23999999463558197)
    
    case .Text / Negative Disabled:
        return UIColor(hexNum: 0x2E0509, alpha: 0.23999999463558197)
    
    case .Text / Warning Disabled:
        return UIColor(hexNum: 0x2B1707, alpha: 0.23999999463558197)
    
    case .Text / Positive Link:
        return UIColor(hexNum: 0x14A420, alpha: 1.0)
    
    case .Text / Negative Link:
        return UIColor(hexNum: 0xED5C68, alpha: 1.0)
    
    case .Text / Warning Link:
        return UIColor(hexNum: 0xD27714, alpha: 1.0)
    
    case .Text / Positive Colored:
        return UIColor(hexNum: 0x008A0B, alpha: 1.0)
    
    case .Text / Negative Colored:
        return UIColor(hexNum: 0xE12E3C, alpha: 1.0)
    
    case .Text / Warning Colored:
        return UIColor(hexNum: 0xA05900, alpha: 1.0)
    
    case .Text / Red Primary:
        return UIColor(hexNum: 0x2E0505, alpha: 1.0)
    
    case .Text / Pink Primary:
        return UIColor(hexNum: 0x370826, alpha: 1.0)
    
    case .Text / Red Secondary:
        return UIColor(hexNum: 0x2E0505, alpha: 0.6399999856948853)
    
    case .Text / Pink Secondary:
        return UIColor(hexNum: 0x2D061F, alpha: 0.6399999856948853)
    
    case .Text / Red Tertiary:
        return UIColor(hexNum: 0x2E0505, alpha: 0.47999998927116394)
    
    case .Text / Pink Tertiary:
        return UIColor(hexNum: 0x2D061F, alpha: 0.47999998927116394)
    
    case .Text / Red Disabled:
        return UIColor(hexNum: 0x2E0505, alpha: 0.23999999463558197)
    
    case .Text / Pink Disabled:
        return UIColor(hexNum: 0x2D061F, alpha: 0.23999999463558197)
    
    case .Text / Red Link:
        return UIColor(hexNum: 0xED5C5D, alpha: 1.0)
    
    case .Text / Pink Link:
        return UIColor(hexNum: 0xEB4CB7, alpha: 1.0)
    
    case .Text / Red Colored:
        return UIColor(hexNum: 0xD01E20, alpha: 1.0)
    
    case .Text / Pink Colored:
        return UIColor(hexNum: 0xC1238E, alpha: 1.0)
    
    case .Bg / Blue Primary:
        return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
    
    case .Button / Blue Primary:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Icon / Blue Primary:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Button / Blue Secondary:
        return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
    
    case .Bg / Warning Primary:
        return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
    
    case .Button / Warning Primary:
        return UIColor(hexNum: 0xFD8021, alpha: 1.0)
    
    case .Icon / Warning Primary:
        return UIColor(hexNum: 0xFD8021, alpha: 1.0)
    
    case .Button / Warning Secondary:
        return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
    
    case .Button / Inverted Primary:
        return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
    
    case .Button / Secondary:
        return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
    
    case .Button / Brand Primary:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Icon / Brand Primary:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Button / Brand Secondary:
        return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
    
    case .Bg / Red Primary:
        return UIColor(hexNum: 0xFFEBEB, alpha: 1.0)
    
    case .Button / Red Primary:
        return UIColor(hexNum: 0xFF7775, alpha: 1.0)
    
    case .Icon / Red Primary:
        return UIColor(hexNum: 0xFF7775, alpha: 1.0)
    
    case .Button / Red Secondary:
        return UIColor(hexNum: 0xFFEBEB, alpha: 1.0)
    
    case .Bg / Salad Primary:
        return UIColor(hexNum: 0xEDFEBD, alpha: 1.0)
    
    case .Button / Salad Primary:
        return UIColor(hexNum: 0xABEB00, alpha: 1.0)
    
    case .Icon / Salad Primary:
        return UIColor(hexNum: 0x74B800, alpha: 1.0)
    
    case .Button / Salad Secondary:
        return UIColor(hexNum: 0xEDFEBD, alpha: 1.0)
    
    case .Bg / Violet Primary:
        return UIColor(hexNum: 0xF9EBFF, alpha: 1.0)
    
    case .Button / Violet Primary:
        return UIColor(hexNum: 0xDE7AFF, alpha: 1.0)
    
    case .Icon / Violet Primary:
        return UIColor(hexNum: 0xDE7AFF, alpha: 1.0)
    
    case .Button / Violet Secondary:
        return UIColor(hexNum: 0xF9EBFF, alpha: 1.0)
    
    case .Bg / Yellow Primary:
        return UIColor(hexNum: 0xFFF7C7, alpha: 1.0)
    
    case .Button / Yellow Primary:
        return UIColor(hexNum: 0xFAD800, alpha: 1.0)
    
    case .Icon / Yellow Primary:
        return UIColor(hexNum: 0xE0A500, alpha: 1.0)
    
    case .Button / Yellow Secondary:
        return UIColor(hexNum: 0xFFF7C7, alpha: 1.0)
    
    case .Bg / Pink Primary:
        return UIColor(hexNum: 0xFFEBF5, alpha: 1.0)
    
    case .Button / Pink Primary:
        return UIColor(hexNum: 0xFF6BBF, alpha: 1.0)
    
    case .Icon / Pink Primary:
        return UIColor(hexNum: 0xFF6BBF, alpha: 1.0)
    
    case .Button / Pink Secondary:
        return UIColor(hexNum: 0xFFEBF5, alpha: 1.0)
    
    case .Bg / Mint Primary:
        return UIColor(hexNum: 0xDBFFE9, alpha: 1.0)
    
    case .Button / Mint Primary:
        return UIColor(hexNum: 0x75F0A6, alpha: 1.0)
    
    case .Icon / Mint Primary:
        return UIColor(hexNum: 0x0ABD5D, alpha: 1.0)
    
    case .Button / Mint Secondary:
        return UIColor(hexNum: 0xDBFFE9, alpha: 1.0)
    
    case .Bg / Orange Primary:
        return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
    
    case .Button / Orange Primary:
        return UIColor(hexNum: 0xFB8023, alpha: 1.0)
    
    case .Icon / Orange Primary:
        return UIColor(hexNum: 0xFB8023, alpha: 1.0)
    
    case .Button / Orange Secondary:
        return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
    
    case .Text / Salad Primary:
        return UIColor(hexNum: 0x111F06, alpha: 1.0)
    
    case .Text / Mint Primary:
        return UIColor(hexNum: 0x07200E, alpha: 1.0)
    
    case .Text / Salad Secondary:
        return UIColor(hexNum: 0x111F06, alpha: 0.6399999856948853)
    
    case .Text / Mint Secondary:
        return UIColor(hexNum: 0x07200E, alpha: 0.6399999856948853)
    
    case .Text / Salad Tertiary:
        return UIColor(hexNum: 0x111F06, alpha: 0.47999998927116394)
    
    case .Text / Mint Tertiary:
        return UIColor(hexNum: 0x07200E, alpha: 0.47999998927116394)
    
    case .Text / Salad Disabled:
        return UIColor(hexNum: 0x111F06, alpha: 0.23999999463558197)
    
    case .Text / Mint Disabled:
        return UIColor(hexNum: 0x07200E, alpha: 0.23999999463558197)
    
    case .Text / Salad Link:
        return UIColor(hexNum: 0x5F9E14, alpha: 1.0)
    
    case .Text / Mint Link:
        return UIColor(hexNum: 0x14A34C, alpha: 1.0)
    
    case .Text / Salad Colored:
        return UIColor(hexNum: 0x457700, alpha: 1.0)
    
    case .Text / Mint Colored:
        return UIColor(hexNum: 0x007B35, alpha: 1.0)
    
    case .Text / Violet Primary:
        return UIColor(hexNum: 0x23082B, alpha: 1.0)
    
    case .Text / Violet Secondary:
        return UIColor(hexNum: 0x23082B, alpha: 0.6399999856948853)
    
    case .Text / Violet Tertiary:
        return UIColor(hexNum: 0x23082B, alpha: 0.47999998927116394)
    
    case .Text / Violet Disabled:
        return UIColor(hexNum: 0x23082B, alpha: 0.23999999463558197)
    
    case .Text / Violet Link:
        return UIColor(hexNum: 0xCD5CEE, alpha: 1.0)
    
    case .Text / Violet Colored:
        return UIColor(hexNum: 0xA339C0, alpha: 1.0)
    
    case .Text / Orange Primary:
        return UIColor(hexNum: 0x2B1707, alpha: 1.0)
    
    case .Text / Orange Secondary:
        return UIColor(hexNum: 0x2B1707, alpha: 0.6399999856948853)
    
    case .Text / Orange Tertiary:
        return UIColor(hexNum: 0x2B1707, alpha: 0.47999998927116394)
    
    case .Text / Orange Disabled:
        return UIColor(hexNum: 0x2B1707, alpha: 0.23999999463558197)
    
    case .Text / Orange Link:
        return UIColor(hexNum: 0xD27714, alpha: 1.0)
    
    case .Text / Orange Colored:
        return UIColor(hexNum: 0xA05900, alpha: 1.0)
    
    case .Bg / Positive Primary:
        return UIColor(hexNum: 0xDBFFDE, alpha: 1.0)
    
    case .Button / Positive Primary:
        return UIColor(hexNum: 0x0ABD25, alpha: 1.0)
    
    case .Icon / Positive Primary:
        return UIColor(hexNum: 0x0ABD25, alpha: 1.0)
    
    case .Button / Positive Secondary:
        return UIColor(hexNum: 0xE5FFE8, alpha: 1.0)
    
    case .Bg / Brand Secondary:
        return UIColor(hexNum: 0xC2F5FF, alpha: 1.0)
    
    case .Bg / Negative Secondary:
        return UIColor(hexNum: 0xFFD6DA, alpha: 1.0)
    
    case .Bg / Negative Solid:
        return UIColor(hexNum: 0xFF7581, alpha: 1.0)
    
    case .Bg / Blue Secondary:
        return UIColor(hexNum: 0xC2F5FF, alpha: 1.0)
    
    case .Bg / Warning Secondary:
        return UIColor(hexNum: 0xFFE4C2, alpha: 1.0)
    
    case .Bg / Warning Solid:
        return UIColor(hexNum: 0xFD8021, alpha: 1.0)
    
    case .Bg / Red Secondary:
        return UIColor(hexNum: 0xFFD7D6, alpha: 1.0)
    
    case .Bg / Salad Secondary:
        return UIColor(hexNum: 0xDBF88B, alpha: 1.0)
    
    case .Bg / Violet Secondary:
        return UIColor(hexNum: 0xF4D6FF, alpha: 1.0)
    
    case .Bg / Yellow Secondary:
        return UIColor(hexNum: 0xFFF08F, alpha: 1.0)
    
    case .Bg / Pink Secondary:
        return UIColor(hexNum: 0xFFD6EC, alpha: 1.0)
    
    case .Bg / Mint Secondary:
        return UIColor(hexNum: 0xB4FDD1, alpha: 1.0)
    
    case .Bg / Orange Secondary:
        return UIColor(hexNum: 0xFFE4C2, alpha: 1.0)
    
    case .Bg / Positive Secondary:
        return UIColor(hexNum: 0xB9FDBF, alpha: 1.0)
    
    case .Bg / Positive Solid:
        return UIColor(hexNum: 0x0ABD25, alpha: 1.0)
    
    case .Bg / Brand Solid:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Bg / Blue Solid:
        return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
    
    case .Bg / Red Solid:
        return UIColor(hexNum: 0xFF7775, alpha: 1.0)
    
    case .Bg / Salad Solid:
        return UIColor(hexNum: 0x74B800, alpha: 1.0)
    
    case .Bg / Violet Solid:
        return UIColor(hexNum: 0xAD61FF, alpha: 1.0)
    
    case .Bg / Yellow Solid:
        return UIColor(hexNum: 0xE0A500, alpha: 1.0)
    
    case .Bg / Pink Solid:
        return UIColor(hexNum: 0xFF6BBF, alpha: 1.0)
    
    case .Bg / Mint Solid:
        return UIColor(hexNum: 0x0ABD5D, alpha: 1.0)
    
    case .Bg / Orange Solid:
        return UIColor(hexNum: 0xFD8021, alpha: 1.0)
    
    case .Bg / Promo Solid:
        return UIColor(hexNum: 0xED5071, alpha: 1.0)
    
    case .Bg / Fullpage Tint:
        return UIColor(hexNum: 0x000000, alpha: 0.3499999940395355)
    
    case .Bg / Toast:
        return UIColor(hexNum: 0x272C30, alpha: 1.0)
    
    case .Icon / Yellow Primary2:
        return UIColor(hexNum: 0xFFB53C, alpha: 1.0)
    
    case .Icon / Pink Primary2:
        return UIColor(hexNum: 0xF31BE5, alpha: 1.0)
    
    case .Icon / Red Primary2:
        return UIColor(hexNum: 0xFF4242, alpha: 1.0)
    
    }
}

extension ThemeColor: CaseIterable {
    var title: String {
        switch self {
        
        case .Text / Primary: return "Text / Primary"
        
        case .Text / Inverted: return "Text / Inverted"
        
        case .Text / Secondary: return "Text / Secondary"
        
        case .Text / Placeholder: return "Text / Placeholder"
        
        case .Text / Tertiary: return "Text / Tertiary"
        
        case .Text / Disabled: return "Text / Disabled"
        
        case .Input / Normal: return "Input / Normal"
        
        case .Skeleton / Primary bg: return "Skeleton / Primary bg"
        
        case .Skeleton / Secondary bg: return "Skeleton / Secondary bg"
        
        case .Controls / Secondary: return "Controls / Secondary"
        
        case .Controls / Primary: return "Controls / Primary"
        
        case .Controls / Secondary Disabled: return "Controls / Secondary Disabled"
        
        case .Controls / Unchecked Light: return "Controls / Unchecked Light"
        
        case .Border / Primary: return "Border / Primary"
        
        case .Border / Secondary: return "Border / Secondary"
        
        case .Input / Active: return "Input / Active"
        
        case .Icon / Dark Primary: return "Icon / Dark Primary"
        
        case .Icon / Inverted Primary: return "Icon / Inverted Primary"
        
        case .Skeleton / Primary gradient: return "Skeleton / Primary gradient"
        
        case .Skeleton / Secondary gradient: return "Skeleton / Secondary gradient"
        
        case .Input / Negative: return "Input / Negative"
        
        case .Input / Positive: return "Input / Positive"
        
        case .Bg / Primary: return "Bg / Primary"
        
        case .Bg / Secondary: return "Bg / Secondary"
        
        case .Bg / Tertiary: return "Bg / Tertiary"
        
        case .Text / Brand: return "Text / Brand"
        
        case .Text / Starred: return "Text / Starred"
        
        case .Bg / Brand Primary: return "Bg / Brand Primary"
        
        case .Bg / Negative Primary: return "Bg / Negative Primary"
        
        case .Button / Negative Solid: return "Button / Negative Solid"
        
        case .Icon / Negative Primary: return "Icon / Negative Primary"
        
        case .Button / Negative Secondary: return "Button / Negative Secondary"
        
        case .Text / Yellow Primary: return "Text / Yellow Primary"
        
        case .Text / Yellow Secondary: return "Text / Yellow Secondary"
        
        case .Text / Yellow Tertiary: return "Text / Yellow Tertiary"
        
        case .Text / Yellow Disabled: return "Text / Yellow Disabled"
        
        case .Text / Yellow Link: return "Text / Yellow Link"
        
        case .Text / Yellow Colored: return "Text / Yellow Colored"
        
        case .Text / Blue Primary: return "Text / Blue Primary"
        
        case .Text / Blue Secondary: return "Text / Blue Secondary"
        
        case .Text / Blue Tertiary : return "Text / Blue Tertiary "
        
        case .Text / Blue Disabled: return "Text / Blue Disabled"
        
        case .Text / Blue Link: return "Text / Blue Link"
        
        case .Text / Blue Colored: return "Text / Blue Colored"
        
        case .Text / Positive Primary: return "Text / Positive Primary"
        
        case .Text / Negative Primary: return "Text / Negative Primary"
        
        case .Text / Warning Primary: return "Text / Warning Primary"
        
        case .Text / Positive Secondary: return "Text / Positive Secondary"
        
        case .Text / Negative Secondary: return "Text / Negative Secondary"
        
        case .Text / Warning Secondary: return "Text / Warning Secondary"
        
        case .Text / Positive Tertiary: return "Text / Positive Tertiary"
        
        case .Text / Negative Tertiary: return "Text / Negative Tertiary"
        
        case .Text / Warning Tertiary: return "Text / Warning Tertiary"
        
        case .Text / Positive Disabled: return "Text / Positive Disabled"
        
        case .Text / Negative Disabled: return "Text / Negative Disabled"
        
        case .Text / Warning Disabled: return "Text / Warning Disabled"
        
        case .Text / Positive Link: return "Text / Positive Link"
        
        case .Text / Negative Link: return "Text / Negative Link"
        
        case .Text / Warning Link: return "Text / Warning Link"
        
        case .Text / Positive Colored: return "Text / Positive Colored"
        
        case .Text / Negative Colored: return "Text / Negative Colored"
        
        case .Text / Warning Colored: return "Text / Warning Colored"
        
        case .Text / Red Primary: return "Text / Red Primary"
        
        case .Text / Pink Primary: return "Text / Pink Primary"
        
        case .Text / Red Secondary: return "Text / Red Secondary"
        
        case .Text / Pink Secondary: return "Text / Pink Secondary"
        
        case .Text / Red Tertiary: return "Text / Red Tertiary"
        
        case .Text / Pink Tertiary: return "Text / Pink Tertiary"
        
        case .Text / Red Disabled: return "Text / Red Disabled"
        
        case .Text / Pink Disabled: return "Text / Pink Disabled"
        
        case .Text / Red Link: return "Text / Red Link"
        
        case .Text / Pink Link: return "Text / Pink Link"
        
        case .Text / Red Colored: return "Text / Red Colored"
        
        case .Text / Pink Colored: return "Text / Pink Colored"
        
        case .Bg / Blue Primary: return "Bg / Blue Primary"
        
        case .Button / Blue Primary: return "Button / Blue Primary"
        
        case .Icon / Blue Primary: return "Icon / Blue Primary"
        
        case .Button / Blue Secondary: return "Button / Blue Secondary"
        
        case .Bg / Warning Primary: return "Bg / Warning Primary"
        
        case .Button / Warning Primary: return "Button / Warning Primary"
        
        case .Icon / Warning Primary: return "Icon / Warning Primary"
        
        case .Button / Warning Secondary: return "Button / Warning Secondary"
        
        case .Button / Inverted Primary: return "Button / Inverted Primary"
        
        case .Button / Secondary: return "Button / Secondary"
        
        case .Button / Brand Primary: return "Button / Brand Primary"
        
        case .Icon / Brand Primary: return "Icon / Brand Primary"
        
        case .Button / Brand Secondary: return "Button / Brand Secondary"
        
        case .Bg / Red Primary: return "Bg / Red Primary"
        
        case .Button / Red Primary: return "Button / Red Primary"
        
        case .Icon / Red Primary: return "Icon / Red Primary"
        
        case .Button / Red Secondary: return "Button / Red Secondary"
        
        case .Bg / Salad Primary: return "Bg / Salad Primary"
        
        case .Button / Salad Primary: return "Button / Salad Primary"
        
        case .Icon / Salad Primary: return "Icon / Salad Primary"
        
        case .Button / Salad Secondary: return "Button / Salad Secondary"
        
        case .Bg / Violet Primary: return "Bg / Violet Primary"
        
        case .Button / Violet Primary: return "Button / Violet Primary"
        
        case .Icon / Violet Primary: return "Icon / Violet Primary"
        
        case .Button / Violet Secondary: return "Button / Violet Secondary"
        
        case .Bg / Yellow Primary: return "Bg / Yellow Primary"
        
        case .Button / Yellow Primary: return "Button / Yellow Primary"
        
        case .Icon / Yellow Primary: return "Icon / Yellow Primary"
        
        case .Button / Yellow Secondary: return "Button / Yellow Secondary"
        
        case .Bg / Pink Primary: return "Bg / Pink Primary"
        
        case .Button / Pink Primary: return "Button / Pink Primary"
        
        case .Icon / Pink Primary: return "Icon / Pink Primary"
        
        case .Button / Pink Secondary: return "Button / Pink Secondary"
        
        case .Bg / Mint Primary: return "Bg / Mint Primary"
        
        case .Button / Mint Primary: return "Button / Mint Primary"
        
        case .Icon / Mint Primary: return "Icon / Mint Primary"
        
        case .Button / Mint Secondary: return "Button / Mint Secondary"
        
        case .Bg / Orange Primary: return "Bg / Orange Primary"
        
        case .Button / Orange Primary: return "Button / Orange Primary"
        
        case .Icon / Orange Primary: return "Icon / Orange Primary"
        
        case .Button / Orange Secondary: return "Button / Orange Secondary"
        
        case .Text / Salad Primary: return "Text / Salad Primary"
        
        case .Text / Mint Primary: return "Text / Mint Primary"
        
        case .Text / Salad Secondary: return "Text / Salad Secondary"
        
        case .Text / Mint Secondary: return "Text / Mint Secondary"
        
        case .Text / Salad Tertiary: return "Text / Salad Tertiary"
        
        case .Text / Mint Tertiary: return "Text / Mint Tertiary"
        
        case .Text / Salad Disabled: return "Text / Salad Disabled"
        
        case .Text / Mint Disabled: return "Text / Mint Disabled"
        
        case .Text / Salad Link: return "Text / Salad Link"
        
        case .Text / Mint Link: return "Text / Mint Link"
        
        case .Text / Salad Colored: return "Text / Salad Colored"
        
        case .Text / Mint Colored: return "Text / Mint Colored"
        
        case .Text / Violet Primary: return "Text / Violet Primary"
        
        case .Text / Violet Secondary: return "Text / Violet Secondary"
        
        case .Text / Violet Tertiary: return "Text / Violet Tertiary"
        
        case .Text / Violet Disabled: return "Text / Violet Disabled"
        
        case .Text / Violet Link: return "Text / Violet Link"
        
        case .Text / Violet Colored: return "Text / Violet Colored"
        
        case .Text / Orange Primary: return "Text / Orange Primary"
        
        case .Text / Orange Secondary: return "Text / Orange Secondary"
        
        case .Text / Orange Tertiary: return "Text / Orange Tertiary"
        
        case .Text / Orange Disabled: return "Text / Orange Disabled"
        
        case .Text / Orange Link: return "Text / Orange Link"
        
        case .Text / Orange Colored: return "Text / Orange Colored"
        
        case .Bg / Positive Primary: return "Bg / Positive Primary"
        
        case .Button / Positive Primary: return "Button / Positive Primary"
        
        case .Icon / Positive Primary: return "Icon / Positive Primary"
        
        case .Button / Positive Secondary: return "Button / Positive Secondary"
        
        case .Bg / Brand Secondary: return "Bg / Brand Secondary"
        
        case .Bg / Negative Secondary: return "Bg / Negative Secondary"
        
        case .Bg / Negative Solid: return "Bg / Negative Solid"
        
        case .Bg / Blue Secondary: return "Bg / Blue Secondary"
        
        case .Bg / Warning Secondary: return "Bg / Warning Secondary"
        
        case .Bg / Warning Solid: return "Bg / Warning Solid"
        
        case .Bg / Red Secondary: return "Bg / Red Secondary"
        
        case .Bg / Salad Secondary: return "Bg / Salad Secondary"
        
        case .Bg / Violet Secondary: return "Bg / Violet Secondary"
        
        case .Bg / Yellow Secondary: return "Bg / Yellow Secondary"
        
        case .Bg / Pink Secondary: return "Bg / Pink Secondary"
        
        case .Bg / Mint Secondary: return "Bg / Mint Secondary"
        
        case .Bg / Orange Secondary: return "Bg / Orange Secondary"
        
        case .Bg / Positive Secondary: return "Bg / Positive Secondary"
        
        case .Bg / Positive Solid: return "Bg / Positive Solid"
        
        case .Bg / Brand Solid: return "Bg / Brand Solid"
        
        case .Bg / Blue Solid: return "Bg / Blue Solid"
        
        case .Bg / Red Solid: return "Bg / Red Solid"
        
        case .Bg / Salad Solid: return "Bg / Salad Solid"
        
        case .Bg / Violet Solid: return "Bg / Violet Solid"
        
        case .Bg / Yellow Solid: return "Bg / Yellow Solid"
        
        case .Bg / Pink Solid: return "Bg / Pink Solid"
        
        case .Bg / Mint Solid: return "Bg / Mint Solid"
        
        case .Bg / Orange Solid: return "Bg / Orange Solid"
        
        case .Bg / Promo Solid: return "Bg / Promo Solid"
        
        case .Bg / Fullpage Tint: return "Bg / Fullpage Tint"
        
        case .Bg / Toast: return "Bg / Toast"
        
        case .Icon / Yellow Primary2: return "Icon / Yellow Primary2"
        
        case .Icon / Pink Primary2: return "Icon / Pink Primary2"
        
        case .Icon / Red Primary2: return "Icon / Red Primary2"
        
        }
    }
}
