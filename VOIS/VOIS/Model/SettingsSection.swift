//
//  SettingsSection.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/26/21.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible{
    case Social
    case Communications
    
    var description: String{
        switch self{
        case .Social:
            return "Social"
        case .Communications:
            return "Communications"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType{
    
    case editProfile
    case changeLanguage
    case logout
    
    var description: String{
        switch self{
        
        case .editProfile:
            return "Edit Profile"
        case .changeLanguage:
            return "Change Language"
        case .logout:
            return "Log Out"
        }
    }
    var containsSwitch: Bool { return false }
}

enum CommunicationsOptions: Int, CaseIterable, SectionType{
    case notifications
    case email
    var description: String{
        switch self{
        
        case .notifications:
            return "Notifications"
        case .email:
            return "Email"
        }
    }
    var containsSwitch: Bool { return true }
}
