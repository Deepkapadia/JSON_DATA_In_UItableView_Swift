//
//  HeroStats.swift
//  JSON_Data_IN_UITableView_With_Image
//
//  Created by DeEp KapaDia on 27/05/18.
//  Copyright © 2018 DeEp KapaDia. All rights reserved.
//

import Foundation

struct HeroStats: Decodable{
    
    let localized_name:String
    let primary_attr:String
    let attack_type:String
    let legs:Int
    let img:String
}

