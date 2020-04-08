//
//  Currency.swift
//  19dz
//
//  Created by Пользователь on 3/27/20.
//  Copyright © 2020 Пользователь. All rights reserved.
//

import Foundation

struct CurrencyModel: Decodable {
    let rates: RatesModel
}

struct RatesModel: Decodable {
    let USD: Double
    let RUB: Double
    let BYN: Double
}
