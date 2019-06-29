//
//  SearchScope.swift
//  DocumentsCoreData
//
//  Created by Drew Boowee on 6/28/19.
//

import Foundation


enum SearchScope: String {
    case all
    case name
    case content
    
    static var titles: [String] {
        get {
            return [SearchScope.all.rawValue, SearchScope.name.rawValue, SearchScope.content.rawValue]
        }
    }
    
    static var scopes: [SearchScope] {
        get {
            return [SearchScope.all, SearchScope.name, SearchScope.content]
        }
    }
}
