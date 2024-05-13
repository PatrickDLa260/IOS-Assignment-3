//
//  BreedsListResponse.swift
//  PawsitivelyPurrfect
//
//  Created by MacBook on 13/5/2024.
//


import Foundation
struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
