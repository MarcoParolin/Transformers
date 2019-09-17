//
//  Battle.swift
//  Transformers
//
//  Created by Marco Parolin on 16/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import ServiceManager

typealias BattleResult = (winner: Team?, matchResults: [MatchResult])

struct Battle {
    
    static func start(_ transformers: [Transformer], result: @escaping (BattleResult) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            // Takes all the autobots and sort them by rank
            var autobots = transformers.filter({ $0.team == Team.autobots }).sorted(by: { $0.rank.orZero < $1.rank.orZero })
            // Takes all the depticons and sort them by rank
            var decepticons = transformers.filter({ $0.team == Team.decepticons }).sorted(by: { $0.rank.orZero < $1.rank.orZero })
            var matchResults: [MatchResult] = []
            
            // Loops until one array is empty
            while !decepticons.isEmpty && !autobots.isEmpty {
                guard let decepticon = decepticons.first, let autobot = autobots.first else {
                    let winnerTeam: Team = decepticons.isEmpty ? .autobots : .decepticons
                    DispatchQueue.main.async {
                        result((winner: winnerTeam, matchResults: matchResults))
                    }
                    return
                }
                
                let match = autobot † decepticon
                // save current match result into an array
                matchResults.append(match)
                guard match.reason != .totalAnnihilation else {
                    // if optimus vs predaking, battle ends earlier
                    DispatchQueue.main.async {
                        result((winner: nil, matchResults: matchResults))
                    }
                    return
                }
                for transformer in match.losers {
                    // delete from array the losing transformers
                    autobots.removeAll(where: { $0.id == transformer.id })
                    decepticons.removeAll(where: { $0.id == transformer.id })
                }
            }
            let winnerTeam: Team = decepticons.isEmpty ? .autobots : .decepticons
            DispatchQueue.main.async {
                result((winner: winnerTeam, matchResults: matchResults))
            }
            return
        }
    }
    
}

enum MatchResultReason {
    case destroyed
    case fleed
    case outskilled
    case tie
    case instaWin
    case totalAnnihilation
}

typealias MatchResult = (winner: Transformer?, losers: [Transformer], reason: MatchResultReason)
// † means battle between two transformers
infix operator †
// operator to check if a transformer should flee
infix operator ©
// operator to check if a transformer should outskill the other
infix operator √
extension Transformer {
    
    /// Operator that check the outcome of a battle between two Transformers
    /// - Parameter lhs: A Transformer
    /// - Parameter rhs: A Transformer
    static func † (lhs: Transformer, rhs: Transformer) -> MatchResult {
        var bossNames: [String] { return ["optimus prime", "predaking"]}
        
        var islhsBoss: Bool { return bossNames.contains(lhs.name?.lowercased()) }
        var isrhsBoss: Bool { return bossNames.contains(rhs.name?.lowercased()) }
        
        // Optimus vr predaking
        if islhsBoss && isrhsBoss {
            return (winner: nil, losers: [], reason: .totalAnnihilation)
        }
        // If lhs is Optimus or Predaking
        if islhsBoss {
            return (winner: lhs, losers: [rhs], reason: .instaWin)
        }
        // If rhs is Optimus or Predaking
        if isrhsBoss {
            return (winner: rhs, losers: [lhs], reason: .instaWin)
        }
        // If  a transformer has a specific courage and strength
        if let shouldFlee = lhs © rhs {
            return (winner: shouldFlee.winner, losers: [shouldFlee.fleed], reason: .fleed)
        }
        // If a transformer has a specific amount of skill
        if let shouldOutskill = lhs √ rhs {
            return (winner: shouldOutskill.winner, losers: [shouldOutskill.outskilled], reason: .outskilled)
        }
        
        // Check for overall rating
        if lhs.overallRating > rhs.overallRating {
            return (winner: lhs, losers: [rhs], reason: .destroyed)
        } else if lhs.overallRating < rhs.overallRating {
            return (winner: rhs, losers: [lhs], reason: .destroyed)
        } else {
            return (winner: nil, losers: [lhs, rhs], reason: .tie)
        }
    }
    
    /// Operator that check if someone between two transformers whould flee
    /// - Parameter lhs: A Transformer
    /// - Parameter rhs: A Transformer
    static func © (lhs: Transformer, rhs: Transformer) -> (winner: Transformer, fleed: Transformer)? {
        let deltaCourage = abs(lhs.courage.orZero-rhs.courage.orZero)
        let deltaStrenght = abs(lhs.strength.orZero-rhs.strength.orZero)
        guard deltaCourage >= 4 && deltaStrenght >= 3 else {
            //no relevant skill is greater
            return nil
        }
        
        if lhs.courage.orZero > rhs.courage.orZero {
            return (winner: lhs, fleed: rhs)
        } else {
            return (winner: rhs, fleed: lhs)
        }
    }
    
    /// Operator that checks id someone between two transformers should outskill the other
    /// - Parameter lhs: A Transformer
    /// - Parameter rhs: A Transformer
    static func √ (lhs: Transformer, rhs: Transformer) -> (winner: Transformer, outskilled: Transformer)? {
        let deltaSkill = abs(lhs.skill.orZero-rhs.skill.orZero)
        guard deltaSkill >= 3 else {
            //One is not more skilled than the other
            return nil
        }
        
        if lhs.skill.orZero > rhs.skill.orZero {
            return (winner: lhs, outskilled: rhs)
        } else {
            return (winner: rhs, outskilled: lhs)
        }
    }
}
