//
//  JsonParser.swift
//  NetworkTest
//
//  Created by 1st-impact on 2019/07/08.
//  Copyright © 2019 S4ch1mos. All rights reserved.
//

import UIKit
import SwiftyJSON

class JsonParser: NSObject {
    class var sharedInstance: JsonParser {
        struct Static {
            static let instance: JsonParser = JsonParser()
        }
        return Static.instance
    }
    
    // 叩くAPIによってparseするタイプを出しわけ
    func parseJson(_ api: API, json: JSON) -> Any? {
        switch api {
        case .profile:
            return self.parseProfileApiJson(json)
        }
    }
    
    // プロフィール画面ユーザー情報取得
    private func parseProfileApiJson(_ json: JSON) -> UserModel {
        let userModel = UserModel()
        userModel.id = json["id"].int
        userModel.name = json["name"].string
        userModel.email = json["email"].string
        userModel.introduction = json["introduction"].string
        userModel.date = json["date"].string
        
        return userModel
    }
}
