//
//  Transformer.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import CoreData

/// A Transfomer expertise
public enum Expertise: String {
    case strenght = "Strong"
    case intelligence = "Intelligent"
    case speed = "Fast"
    case endurance = "Resistant"
    case courage = "Braveheart"
    case firepower = "Deadly"
    case skill = "Expert"
}

public class Transformer: ResponseObject, Hashable {
    
    public var id: String?
    public var name: String?
    public var team: Team?
    public var team_icon: String?
    public var strength: Int?
    public var intelligence: Int?
    public var speed: Int?
    public var endurance: Int?
    public var rank: Int?
    public var courage: Int?
    public var firepower: Int?
    public var skill: Int?
    
    // MARK: Computed properties
    public var overallRating: Int {
        return strength.orZero + intelligence.orZero + speed.orZero + endurance.orZero + firepower.orZero
    }
    
    public var expertises: [Expertise] {
        var params: [(expertise: Expertise, value: Int)] = [
            (expertise: .strenght, value: self.strength.orZero),
            (expertise: .intelligence, value: self.intelligence.orZero),
            (expertise: .speed, value: self.speed.orZero),
            (expertise: .endurance, value: self.endurance.orZero),
            (expertise: .courage, value: self.courage.orZero),
            (expertise: .firepower, value: self.firepower.orZero),
            (expertise: .skill, value: self.skill.orZero)
        ]
        
        var expertises: [Expertise?] = []
        
        for _ in 0...2 {
            let max = params.max { $0.value < $1.value }
            params.removeAll { $0.expertise == max?.expertise }
            expertises.append(max?.expertise)
        }
        
        return expertises.compactMap { $0 }
    }
    
    // MARK: Custom Encoder / Decoder
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case team
        case team_icon
        case strength
        case intelligence
        case speed
        case endurance
        case rank
        case courage
        case firepower
        case skill
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // Why am i getting a string instead of a Int?
            self.id = try? container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.team = try container.decode(Team.self, forKey: .team)
            self.team_icon = try container.decode(String.self, forKey: .team_icon)
            self.strength = try container.decode(Int.self, forKey: .strength)
            self.intelligence = try container.decode(Int.self, forKey: .intelligence)
            self.speed = try container.decode(Int.self, forKey: .speed)
            self.endurance = try container.decode(Int.self, forKey: .endurance)
            self.rank = try container.decode(Int.self, forKey: .rank)
            self.courage = try container.decode(Int.self, forKey: .courage)
            self.firepower = try container.decode(Int.self, forKey: .firepower)
            self.skill = try container.decode(Int.self, forKey: .skill)
            
        } catch let error {
            print("Error while decoding Transformer: \(error)")
        }
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        do {
            try container.encodeIfPresent(id, forKey: .id)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(team, forKey: .team)
            try container.encodeIfPresent(team_icon, forKey: .team_icon)
            try container.encodeIfPresent(strength, forKey: .strength)
            try container.encodeIfPresent(intelligence, forKey: .intelligence)
            try container.encodeIfPresent(speed, forKey: .speed)
            try container.encodeIfPresent(endurance, forKey: .endurance)
            try container.encodeIfPresent(rank, forKey: .rank)
            try container.encodeIfPresent(courage, forKey: .courage)
            try container.encodeIfPresent(firepower, forKey: .firepower)
            try container.encodeIfPresent(skill, forKey: .skill)
            try super.encode(to: encoder)
        } catch let error {
            print("Error while encoding Transformer: \(error)")
        }
    }
    
    required init(_ transformer: ManagedTransformer) {
        super.init()
        self.id = transformer.id
        self.name = transformer.name
        if let team = transformer.team {
            self.team = Team(rawValue: team)
        }
        self.team_icon = transformer.team_icon
        self.strength = Int(transformer.strength)
        self.intelligence = Int(transformer.intelligence)
        self.speed = Int(transformer.speed)
        self.endurance = Int(transformer.endurance)
        self.rank = Int(transformer.rank)
        self.courage = Int(transformer.courage)
        self.firepower = Int(transformer.firepower)
        self.skill = Int(transformer.skill)
    }
    
    required init(stringValue: String) {
        super.init(stringValue: stringValue)
    }
    
    public init(name: String? = "", team: Team? = nil, team_icon: String? = "", strength: Int? = 1, intelligence: Int? = 1, speed: Int? = 1, endurance: Int? = 1, rank: Int? = 1, courage: Int? = 1, firepower: Int? = 1, skill: Int? = 1) {
        super.init()
        self.name = name
        self.team = team
        self.team_icon = team_icon
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
    }
    
    required init() {
        super.init()
    }
    
    /// Convert a Transformer into a CoreData Object
    func asManagedTransformer() -> ManagedTransformer {
        guard let entity = NSEntityDescription.entity(forEntityName: "ManagedTransformer", in: CoreDataManager.shared.persistentContainer.viewContext) else {
            fatalError()
        }
        let transformer = ManagedTransformer(entity: entity, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
        
        transformer.name = self.name
        transformer.team = self.team?.rawValue
        transformer.team_icon = self.team_icon
        transformer.strength = Int16(self.strength ?? 0)
        transformer.intelligence = Int16(self.intelligence ?? 0)
        transformer.speed = Int16(self.speed ?? 0)
        transformer.endurance = Int16(self.endurance ?? 0)
        transformer.rank = Int16(self.rank ?? 0)
        transformer.courage = Int16(self.courage ?? 0)
        transformer.firepower = Int16(self.firepower ?? 0)
        transformer.skill = Int16(self.skill ?? 0)
        
        return transformer
    }
    
    // MARK: Conform to Hashable
    public static func == (lhs: Transformer, rhs: Transformer) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine([id.hashValue, strength, intelligence, speed, endurance, rank, courage, firepower, skill, name.hashValue, team.hashValue].arrayHash)
    }
    
}

public enum Team: String, Codable {
    case autobots = "A"
    case decepticons = "D"
}
