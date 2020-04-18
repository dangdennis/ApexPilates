//
//  Exercise+Extension.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import Foundation

extension Exercise: Identifiable {
    public var wrappedName: String {
        self.name ?? "Unknown Exercise"
    }
    
    public var wrappedID: String {
        self.id?.uuidString ?? ""
    }
}
