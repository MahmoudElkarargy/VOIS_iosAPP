//
//  MenuOption.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
        
    case Features
    case TriggerWords
    case SoftwareUpdates
    case Settings
    
    var description: String {
        switch self{
        
        case .Features:
            return "Features"
        case .TriggerWords:
            return "Trigger words"
        case .SoftwareUpdates:
            return "Software Updates"
        case .Settings:
            return "Settings"
        }
    }
    
    var image: UIImage{
        switch self{
        
        case .Features:
            return UIImage(named: "Features") ?? UIImage()
        case .TriggerWords:
            return UIImage(named: "Triggered") ?? UIImage()
        case .SoftwareUpdates:
            return UIImage(named: "Software") ?? UIImage()
        case .Settings:
            return UIImage(named: "Settings") ?? UIImage()
        }
    }
}
