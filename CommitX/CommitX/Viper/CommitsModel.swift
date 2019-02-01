//
//  CommitsModel.swift
//  CommitX
//
//  Created by Milan Shah on 1/31/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CommitsModel: Object, Decodable {
    
    @objc dynamic var node_id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var message: String = ""
    
    override static func primaryKey() -> String? {
        return "node_id"
    }
    
    private enum CommitCodingKeys: String, CodingKey {
        case node_id
        case url
        case commit, author, name, date
        case message
    }
    
    convenience init(_ node_id: String, _ name: String, _ url: String , _ date: String, _ message: String) {
        self.init()
        self.node_id = node_id
        self.name = name
        self.url = url
        self.date = date
        self.message = message
    }
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CommitCodingKeys.self)
        
        let node_id = try values.decode(String.self, forKey: .node_id)
        let url = try values.decode(String.self, forKey: .url)
        
        // Commits
        let commit = try values.nestedContainer(keyedBy: CommitCodingKeys.self, forKey: .commit)
        
        // Message
        let message = try commit.decode(String.self, forKey: .message)
        
        // Author - name - email - date
        let author = try commit.nestedContainer(keyedBy: CommitCodingKeys.self, forKey: .author)
        let name = try author.decode(String.self, forKey: .name)
        let date = try author.decode(String.self, forKey: .date)
        
        self.init(node_id, name, url, date, message)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
