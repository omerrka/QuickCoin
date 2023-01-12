//
//  API.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Moya
import Alamofire



let apikey = "0D3F5B3C-F198-4CBA-9E60-3C2D93ECAF0C"

enum API {
    case homeScreen(firstCurrency: String, secondCurrency: String)
    case searchScreen(searchedCurrency: String)
    case detailScreen(firstCurrency: String, secondCurrency: String, periodID: String, limit: String, timeStart: String, timeEnd: String)
    
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .homeScreen(let firstCurrency, let secondCurrency):
            return "\(firstCurrency)/\(secondCurrency)"
        case .searchScreen(let searchedCurrency):
            return "\(searchedCurrency)"
        case .detailScreen(let firstCurrency, let secondCurrency,_,_,_,_):
            return "\(firstCurrency)/\(secondCurrency)/history"
        }
    }
    
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        var params: [String: Any] = [:]
        params["apikey"] = apikey
        
        switch self {
        case .homeScreen:
            return .requestParameters(parameters: ["apikey": apikey], encoding: URLEncoding.queryString)
        case .searchScreen:
            return .requestParameters(parameters: ["apikey": apikey], encoding: URLEncoding.queryString)
        case let .detailScreen(_, _, periodID, limit, timeStart, timeEnd):
            params["period_id"] = periodID
            params["limit"] = limit
            params["time_start"] = timeStart
            params["time_end"] = timeEnd
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}


