//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by Yujean Cho on 2022/08/09.
//

import Foundation

struct StationResponseModel: Decodable {
    var stations: [Station] { searchInfo.row } // StationResponseModel().stations 로 간결하게 사용할 수 있도록
    private let searchInfo: SearchInfoBySubwayNameServiceModel // private 가 아니었다면 StationResponseModel().searchInfo.row 로 사용
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
    }
}

struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
