//
//  StringExtension.swift
//  instagram
//
//  Created by Icelod on 11/11/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import Foundation

extension String {
    func safeDatabaseKey() -> String{
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
