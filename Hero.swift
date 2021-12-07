//
//  Hero.swift
//  DotaCodable
//
//  Created by Admin on 12/1/21.
//

import Foundation

struct Hero: Codable {
    let name: String
    let primaryAttribute: String
    let attackType: String
    let legs: Int
    let image: String
    //let favorite: Bool
    
    /*
     Codable types can declare a special nested enumeration named CodingKeys that conforms to the CodingKey protocol. When this enumeration is present, its cases serve as the authoritative list of properties that must be included when instances of a codable type are encoded or decoded. The names of the enumeration cases should match the names you've given to the corresponding properties in your type.
     https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
     */
    enum CodingKeys: String, CodingKey {
        case name = "localized_name"
        case primaryAttribute = "primary_attr"
        case attackType = "attack_type"
        case legs = "legs"
        case image = "img"
        //case favorite = "false"
    }
}
