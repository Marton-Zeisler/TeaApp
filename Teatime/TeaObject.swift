//
//  TeaObject.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 09..
//  Copyright © 2018. marton. All rights reserved.
//

import Foundation
import RealmSwift

class TeaObject: Object{
    @objc dynamic var teaType = ""
    @objc dynamic var teaTaste = 0
    @objc dynamic var teaWater = 0
    @objc dynamic var teaTemp = 0
    @objc dynamic var teaTime = 0
}


