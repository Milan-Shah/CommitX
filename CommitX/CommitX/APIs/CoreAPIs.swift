//
//  CoreAPIs.swift
//  CommitX
//
//  Created by Milan Shah on 1/31/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation

struct Base {
    static let route = "https://api.github.com/repositories/44838949/commits"
}

protocol CoreAPI {
    var path: String { get }
    var url: URL { get }
}

enum CoreAPIs {
    
    enum commits: CoreAPI {
        
        case getCommits
        internal var path: String {
            return "?per_page=100&sha=f45309246584ebdbc0cd6f4960c3f2103ff76a76"
        }
        public var url: URL {
            return URL(string: String(format: "%@%@", Base.route, path))! // One of those places where we would want our app to crash if its nil so force wrapping with (!)
        }
    }
}
