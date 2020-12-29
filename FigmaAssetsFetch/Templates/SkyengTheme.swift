import UIKit

public class SkyengTheme: Theme {
    
    public init() {
    }
    
    public func color(_ color: ThemeColor) -> UIColor {
        switch color {
        
        case .textPrimary:
            return UIColor(hexNum: 0x04121B, alpha: 1.0)
        
        case .textInverted:
            return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
        
        case .textSecondary:
            return UIColor(hexNum: 0x04121B, alpha: 0.6399999856948853)
        
        case .textPlaceholder:
            return UIColor(hexNum: 0x04121B, alpha: 0.36000001430511475)
        
        case .textTertiary:
            return UIColor(hexNum: 0x04121B, alpha: 0.47999998927116394)
        
        case .textDisabled:
            return UIColor(hexNum: 0x04121B, alpha: 0.23999999463558197)
        
        case .inputNormal:
            return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
        
        case .skeletonPrimaryBg:
            return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
        
        case .skeletonSecondaryBg:
            return UIColor(hexNum: 0xEEEEEE, alpha: 1.0)
        
        case .controlsSecondary:
            return UIColor(hexNum: 0xCBCDCF, alpha: 1.0)
        
        case .controlsPrimary:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .controlsSecondaryDisabled:
            return UIColor(hexNum: 0xE9EAEB, alpha: 1.0)
        
        case .controlsUncheckedLight:
            return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
        
        case .borderPrimary:
            return UIColor(hexNum: 0x242D34, alpha: 0.10000000149011612)
        
        case .borderSecondary:
            return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
        
        case .inputActive:
            return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
        
        case .iconDarkPrimary:
            return UIColor(hexNum: 0x04121B, alpha: 0.47999998927116394)
        
        case .iconInvertedPrimary:
            return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
        
        case .skeletonPrimaryGradient:
            return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
        
        case .skeletonSecondaryGradient:
            return UIColor(hexNum: 0xF9F9F9, alpha: 1.0)
        
        case .inputNegative:
            return UIColor(hexNum: 0xFFEBED, alpha: 1.0)
        
        case .inputPositive:
            return UIColor(hexNum: 0xDBFFDE, alpha: 1.0)
        
        case .bgPrimary:
            return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
        
        case .bgSecondary:
            return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
        
        case .bgTertiary:
            return UIColor(hexNum: 0xE9ECED, alpha: 1.0)
        
        case .textBrand:
            return UIColor(hexNum: 0x00A6F0, alpha: 1.0)
        
        case .textStarred:
            return UIColor(hexNum: 0xFFC71D, alpha: 1.0)
        
        case .bgBrandPrimary:
            return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
        
        case .bgNegativePrimary:
            return UIColor(hexNum: 0xFFEBED, alpha: 1.0)
        
        case .buttonNegativeSolid:
            return UIColor(hexNum: 0xFF7581, alpha: 1.0)
        
        case .iconNegativePrimary:
            return UIColor(hexNum: 0xFF7581, alpha: 1.0)
        
        case .buttonNegativeSecondary:
            return UIColor(hexNum: 0xFFF0F1, alpha: 1.0)
        
        case .textYellowPrimary:
            return UIColor(hexNum: 0x271907, alpha: 1.0)
        
        case .textYellowSecondary:
            return UIColor(hexNum: 0x271907, alpha: 0.6399999856948853)
        
        case .textYellowTertiary:
            return UIColor(hexNum: 0x271907, alpha: 0.47999998927116394)
        
        case .textYellowDisabled:
            return UIColor(hexNum: 0x271907, alpha: 0.23999999463558197)
        
        case .textYellowLink:
            return UIColor(hexNum: 0xC08114, alpha: 1.0)
        
        case .textYellowColored:
            return UIColor(hexNum: 0x926100, alpha: 1.0)
        
        case .textBluePrimary:
            return UIColor(hexNum: 0x091E2A, alpha: 1.0)
        
        case .textBlueSecondary:
            return UIColor(hexNum: 0x091E2A, alpha: 0.6399999856948853)
        
        case .textBlueTertiary:
            return UIColor(hexNum: 0x091E2A, alpha: 0.47999998927116394)
        
        case .textBlueDisabled:
            return UIColor(hexNum: 0x091E2A, alpha: 0.23999999463558197)
        
        case .textBlueLink:
            return UIColor(hexNum: 0x1797CC, alpha: 1.0)
        
        case .textBlueColored:
            return UIColor(hexNum: 0x0070AB, alpha: 1.0)
        
        case .textPositivePrimary:
            return UIColor(hexNum: 0x062108, alpha: 1.0)
        
        case .textNegativePrimary:
            return UIColor(hexNum: 0x2E0509, alpha: 1.0)
        
        case .textWarningPrimary:
            return UIColor(hexNum: 0x2B1707, alpha: 1.0)
        
        case .textPositiveSecondary:
            return UIColor(hexNum: 0x062108, alpha: 0.6399999856948853)
        
        case .textNegativeSecondary:
            return UIColor(hexNum: 0x2E0509, alpha: 0.6399999856948853)
        
        case .textWarningSecondary:
            return UIColor(hexNum: 0x2B1707, alpha: 0.6399999856948853)
        
        case .textPositiveTertiary:
            return UIColor(hexNum: 0x062108, alpha: 0.47999998927116394)
        
        case .textNegativeTertiary:
            return UIColor(hexNum: 0x2E0509, alpha: 0.47999998927116394)
        
        case .textWarningTertiary:
            return UIColor(hexNum: 0x2B1707, alpha: 0.47999998927116394)
        
        case .textPositiveDisabled:
            return UIColor(hexNum: 0x062108, alpha: 0.23999999463558197)
        
        case .textNegativeDisabled:
            return UIColor(hexNum: 0x2E0509, alpha: 0.23999999463558197)
        
        case .textWarningDisabled:
            return UIColor(hexNum: 0x2B1707, alpha: 0.23999999463558197)
        
        case .textPositiveLink:
            return UIColor(hexNum: 0x14A420, alpha: 1.0)
        
        case .textNegativeLink:
            return UIColor(hexNum: 0xED5C68, alpha: 1.0)
        
        case .textWarningLink:
            return UIColor(hexNum: 0xD27714, alpha: 1.0)
        
        case .textPositiveColored:
            return UIColor(hexNum: 0x008A0B, alpha: 1.0)
        
        case .textNegativeColored:
            return UIColor(hexNum: 0xE12E3C, alpha: 1.0)
        
        case .textWarningColored:
            return UIColor(hexNum: 0xA05900, alpha: 1.0)
        
        case .textRedPrimary:
            return UIColor(hexNum: 0x2E0505, alpha: 1.0)
        
        case .textPinkPrimary:
            return UIColor(hexNum: 0x370826, alpha: 1.0)
        
        case .textRedSecondary:
            return UIColor(hexNum: 0x2E0505, alpha: 0.6399999856948853)
        
        case .textPinkSecondary:
            return UIColor(hexNum: 0x2D061F, alpha: 0.6399999856948853)
        
        case .textRedTertiary:
            return UIColor(hexNum: 0x2E0505, alpha: 0.47999998927116394)
        
        case .textPinkTertiary:
            return UIColor(hexNum: 0x2D061F, alpha: 0.47999998927116394)
        
        case .textRedDisabled:
            return UIColor(hexNum: 0x2E0505, alpha: 0.23999999463558197)
        
        case .textPinkDisabled:
            return UIColor(hexNum: 0x2D061F, alpha: 0.23999999463558197)
        
        case .textRedLink:
            return UIColor(hexNum: 0xED5C5D, alpha: 1.0)
        
        case .textPinkLink:
            return UIColor(hexNum: 0xEB4CB7, alpha: 1.0)
        
        case .textRedColored:
            return UIColor(hexNum: 0xD01E20, alpha: 1.0)
        
        case .textPinkColored:
            return UIColor(hexNum: 0xC1238E, alpha: 1.0)
        
        case .bgBluePrimary:
            return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
        
        case .buttonBluePrimary:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .iconBluePrimary:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .buttonBlueSecondary:
            return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
        
        case .bgWarningPrimary:
            return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
        
        case .buttonWarningPrimary:
            return UIColor(hexNum: 0xFD8021, alpha: 1.0)
        
        case .iconWarningPrimary:
            return UIColor(hexNum: 0xFD8021, alpha: 1.0)
        
        case .buttonWarningSecondary:
            return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
        
        case .buttonInvertedPrimary:
            return UIColor(hexNum: 0xFFFFFF, alpha: 1.0)
        
        case .buttonSecondary:
            return UIColor(hexNum: 0xF4F5F6, alpha: 1.0)
        
        case .buttonBrandPrimary:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .iconBrandPrimary:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .buttonBrandSecondary:
            return UIColor(hexNum: 0xE4FBFF, alpha: 1.0)
        
        case .bgRedPrimary:
            return UIColor(hexNum: 0xFFEBEB, alpha: 1.0)
        
        case .buttonRedPrimary:
            return UIColor(hexNum: 0xFF7775, alpha: 1.0)
        
        case .iconRedPrimary:
            return UIColor(hexNum: 0xFF7775, alpha: 1.0)
        
        case .buttonRedSecondary:
            return UIColor(hexNum: 0xFFEBEB, alpha: 1.0)
        
        case .bgSaladPrimary:
            return UIColor(hexNum: 0xEDFEBD, alpha: 1.0)
        
        case .buttonSaladPrimary:
            return UIColor(hexNum: 0xABEB00, alpha: 1.0)
        
        case .iconSaladPrimary:
            return UIColor(hexNum: 0x74B800, alpha: 1.0)
        
        case .buttonSaladSecondary:
            return UIColor(hexNum: 0xEDFEBD, alpha: 1.0)
        
        case .bgVioletPrimary:
            return UIColor(hexNum: 0xF9EBFF, alpha: 1.0)
        
        case .buttonVioletPrimary:
            return UIColor(hexNum: 0xDE7AFF, alpha: 1.0)
        
        case .iconVioletPrimary:
            return UIColor(hexNum: 0xDE7AFF, alpha: 1.0)
        
        case .buttonVioletSecondary:
            return UIColor(hexNum: 0xF9EBFF, alpha: 1.0)
        
        case .bgYellowPrimary:
            return UIColor(hexNum: 0xFFF7C7, alpha: 1.0)
        
        case .buttonYellowPrimary:
            return UIColor(hexNum: 0xFAD800, alpha: 1.0)
        
        case .iconYellowPrimary:
            return UIColor(hexNum: 0xE0A500, alpha: 1.0)
        
        case .buttonYellowSecondary:
            return UIColor(hexNum: 0xFFF7C7, alpha: 1.0)
        
        case .bgPinkPrimary:
            return UIColor(hexNum: 0xFFEBF5, alpha: 1.0)
        
        case .buttonPinkPrimary:
            return UIColor(hexNum: 0xFF6BBF, alpha: 1.0)
        
        case .iconPinkPrimary:
            return UIColor(hexNum: 0xFF6BBF, alpha: 1.0)
        
        case .buttonPinkSecondary:
            return UIColor(hexNum: 0xFFEBF5, alpha: 1.0)
        
        case .bgMintPrimary:
            return UIColor(hexNum: 0xDBFFE9, alpha: 1.0)
        
        case .buttonMintPrimary:
            return UIColor(hexNum: 0x75F0A6, alpha: 1.0)
        
        case .iconMintPrimary:
            return UIColor(hexNum: 0x0ABD5D, alpha: 1.0)
        
        case .buttonMintSecondary:
            return UIColor(hexNum: 0xDBFFE9, alpha: 1.0)
        
        case .bgOrangePrimary:
            return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
        
        case .buttonOrangePrimary:
            return UIColor(hexNum: 0xFB8023, alpha: 1.0)
        
        case .iconOrangePrimary:
            return UIColor(hexNum: 0xFB8023, alpha: 1.0)
        
        case .buttonOrangeSecondary:
            return UIColor(hexNum: 0xFFF2E0, alpha: 1.0)
        
        case .textSaladPrimary:
            return UIColor(hexNum: 0x111F06, alpha: 1.0)
        
        case .textMintPrimary:
            return UIColor(hexNum: 0x07200E, alpha: 1.0)
        
        case .textSaladSecondary:
            return UIColor(hexNum: 0x111F06, alpha: 0.6399999856948853)
        
        case .textMintSecondary:
            return UIColor(hexNum: 0x07200E, alpha: 0.6399999856948853)
        
        case .textSaladTertiary:
            return UIColor(hexNum: 0x111F06, alpha: 0.47999998927116394)
        
        case .textMintTertiary:
            return UIColor(hexNum: 0x07200E, alpha: 0.47999998927116394)
        
        case .textSaladDisabled:
            return UIColor(hexNum: 0x111F06, alpha: 0.23999999463558197)
        
        case .textMintDisabled:
            return UIColor(hexNum: 0x07200E, alpha: 0.23999999463558197)
        
        case .textSaladLink:
            return UIColor(hexNum: 0x5F9E14, alpha: 1.0)
        
        case .textMintLink:
            return UIColor(hexNum: 0x14A34C, alpha: 1.0)
        
        case .textSaladColored:
            return UIColor(hexNum: 0x457700, alpha: 1.0)
        
        case .textMintColored:
            return UIColor(hexNum: 0x007B35, alpha: 1.0)
        
        case .textVioletPrimary:
            return UIColor(hexNum: 0x23082B, alpha: 1.0)
        
        case .textVioletSecondary:
            return UIColor(hexNum: 0x23082B, alpha: 0.6399999856948853)
        
        case .textVioletTertiary:
            return UIColor(hexNum: 0x23082B, alpha: 0.47999998927116394)
        
        case .textVioletDisabled:
            return UIColor(hexNum: 0x23082B, alpha: 0.23999999463558197)
        
        case .textVioletLink:
            return UIColor(hexNum: 0xCD5CEE, alpha: 1.0)
        
        case .textVioletColored:
            return UIColor(hexNum: 0xA339C0, alpha: 1.0)
        
        case .textOrangePrimary:
            return UIColor(hexNum: 0x2B1707, alpha: 1.0)
        
        case .textOrangeSecondary:
            return UIColor(hexNum: 0x2B1707, alpha: 0.6399999856948853)
        
        case .textOrangeTertiary:
            return UIColor(hexNum: 0x2B1707, alpha: 0.47999998927116394)
        
        case .textOrangeDisabled:
            return UIColor(hexNum: 0x2B1707, alpha: 0.23999999463558197)
        
        case .textOrangeLink:
            return UIColor(hexNum: 0xD27714, alpha: 1.0)
        
        case .textOrangeColored:
            return UIColor(hexNum: 0xA05900, alpha: 1.0)
        
        case .bgPositivePrimary:
            return UIColor(hexNum: 0xDBFFDE, alpha: 1.0)
        
        case .buttonPositivePrimary:
            return UIColor(hexNum: 0x0ABD25, alpha: 1.0)
        
        case .iconPositivePrimary:
            return UIColor(hexNum: 0x0ABD25, alpha: 1.0)
        
        case .buttonPositiveSecondary:
            return UIColor(hexNum: 0xE5FFE8, alpha: 1.0)
        
        case .bgBrandSecondary:
            return UIColor(hexNum: 0xC2F5FF, alpha: 1.0)
        
        case .bgNegativeSecondary:
            return UIColor(hexNum: 0xFFD6DA, alpha: 1.0)
        
        case .bgNegativeSolid:
            return UIColor(hexNum: 0xFF7581, alpha: 1.0)
        
        case .bgBlueSecondary:
            return UIColor(hexNum: 0xC2F5FF, alpha: 1.0)
        
        case .bgWarningSecondary:
            return UIColor(hexNum: 0xFFE4C2, alpha: 1.0)
        
        case .bgWarningSolid:
            return UIColor(hexNum: 0xFD8021, alpha: 1.0)
        
        case .bgRedSecondary:
            return UIColor(hexNum: 0xFFD7D6, alpha: 1.0)
        
        case .bgSaladSecondary:
            return UIColor(hexNum: 0xDBF88B, alpha: 1.0)
        
        case .bgVioletSecondary:
            return UIColor(hexNum: 0xF4D6FF, alpha: 1.0)
        
        case .bgYellowSecondary:
            return UIColor(hexNum: 0xFFF08F, alpha: 1.0)
        
        case .bgPinkSecondary:
            return UIColor(hexNum: 0xFFD6EC, alpha: 1.0)
        
        case .bgMintSecondary:
            return UIColor(hexNum: 0xB4FDD1, alpha: 1.0)
        
        case .bgOrangeSecondary:
            return UIColor(hexNum: 0xFFE4C2, alpha: 1.0)
        
        case .bgPositiveSecondary:
            return UIColor(hexNum: 0xB9FDBF, alpha: 1.0)
        
        case .bgPositiveSolid:
            return UIColor(hexNum: 0x0ABD25, alpha: 1.0)
        
        case .bgBrandSolid:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .bgBlueSolid:
            return UIColor(hexNum: 0x00AEFA, alpha: 1.0)
        
        case .bgRedSolid:
            return UIColor(hexNum: 0xFF7775, alpha: 1.0)
        
        case .bgSaladSolid:
            return UIColor(hexNum: 0x74B800, alpha: 1.0)
        
        case .bgVioletSolid:
            return UIColor(hexNum: 0xAD61FF, alpha: 1.0)
        
        case .bgYellowSolid:
            return UIColor(hexNum: 0xE0A500, alpha: 1.0)
        
        case .bgPinkSolid:
            return UIColor(hexNum: 0xFF6BBF, alpha: 1.0)
        
        case .bgMintSolid:
            return UIColor(hexNum: 0x0ABD5D, alpha: 1.0)
        
        case .bgOrangeSolid:
            return UIColor(hexNum: 0xFD8021, alpha: 1.0)
        
        case .bgPromoSolid:
            return UIColor(hexNum: 0xED5071, alpha: 1.0)
        
        case .bgFullpageTint:
            return UIColor(hexNum: 0x000000, alpha: 0.3499999940395355)
        
        case .bgToast:
            return UIColor(hexNum: 0x272C30, alpha: 1.0)
        
        case .iconYellowPrimary2:
            return UIColor(hexNum: 0xFFB53C, alpha: 1.0)
        
        case .iconPinkPrimary2:
            return UIColor(hexNum: 0xF31BE5, alpha: 1.0)
        
        case .iconRedPrimary2:
            return UIColor(hexNum: 0xFF4242, alpha: 1.0)
        
        }
    }
    
    public func textStyle(_ textStyle: ThemeTypography) -> TextStyle {
        switch textStyle {
        case .title1: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .title4: return .title4
        case .body: return .body
        case .bodyAccent: return .bodyAccent
        case .body2: return .body2
        case .body2Accent: return .body2Accent
        case .footnote: return .footnote
        case .footnoteAccent: return .footnoteAccent
        case .caption: return .caption
        case .captionBold: return .captionBold
        }
    }
}

