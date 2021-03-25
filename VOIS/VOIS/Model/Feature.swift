//
//  Feature.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit

enum FeatureOption: Int, CustomStringConvertible {
        
    case moneyCounter
    case lightnessDetection
    case objectDetection
    case textScanner
    case colorDetection
    
    var description: String {
        switch self{
        case .moneyCounter:
            return ("Money Counter")
        case .lightnessDetection:
            return("Lightness Detection")
        case .objectDetection:
            return("Object Detection")
        case .textScanner:
            return("Text Scanner")
        case .colorDetection:
            return("Color Detection")
        }
    }
    
    var image: UIImage{
        switch self{
            
        case .moneyCounter:
            return UIImage(named: "AppLogo") ?? UIImage()
        case .lightnessDetection:
            return UIImage(named: "AppLogo") ?? UIImage()
        case .objectDetection:
            return UIImage(named: "AppLogo") ?? UIImage()
        case .textScanner:
            return UIImage(named: "AppLogo") ?? UIImage()
        case .colorDetection:
            return UIImage(named: "AppLogo") ?? UIImage()
        }
    }
}