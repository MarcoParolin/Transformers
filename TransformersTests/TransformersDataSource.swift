//
//  TransformersDataSource.swift
//  TransformersTests
//
//  Created by Marco Parolin on 17/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import ServiceManager

struct TransformersDataSource {
    /// First match should end in tie, so both are destroyed, then autobos win
    static var tieCase: [Transformer] {
        return [
            Transformer(id: 123, name: "Autobot 1", team: .autobots, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
            Transformer(id: 345, name: "Autobot 2", team: .autobots, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
            Transformer(id: 567, name: "Decepticon 1", team: .decepticons, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
        ]
    }
    
    /// Decepticon 1 should flee from Autobot 1
    static var fleeCase: [Transformer] {
        return [
            Transformer(id: 123, name: "Autobot 1", team: .autobots, team_icon: nil, strength: 10, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 10, firepower: 1, skill: 1),
            Transformer(id: 567, name: "Decepticon 1", team: .decepticons, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
        ]
    }
    
    /// Decepticon 1 should be outskilled from Autobot 1
    static var outskillCase: [Transformer] {
        return [
            Transformer(id: 123, name: "Autobot 1", team: .autobots, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 10),
            Transformer(id: 567, name: "Decepticon 1", team: .decepticons, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
        ]
    }
    
    /// Decepticons should win
    static var bossCase: [Transformer] {
        return [
            // Note: is "optimus", not "optimus prime"
            Transformer(id: 123, name: "optimus", team: .autobots, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
            Transformer(id: 567, name: "predaking", team: .decepticons, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
        ]
    }
    
    /// All should die
    static var destructionCase: [Transformer] {
        return [
            Transformer(id: 123, name: "optimus prime", team: .autobots, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
            Transformer(id: 345, name: "predaking", team: .decepticons, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
            Transformer(id: 567, name: "Autobot 1", team: .autobots, team_icon: nil, strength: 10, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 10, firepower: 1, skill: 1),
            Transformer(id: 789, name: "Decepticon 1", team: .decepticons, team_icon: nil, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1),
        ]
    }
}
