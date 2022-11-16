//
//  NT_API.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
import Moya
enum NT_API{
    
    case normalRequest(String,[String:Any],Moya.Method)
    case imNormalRequest(String,[String:Any],Moya.Method)
    case uploadRequest(String,[MultipartFormData],[String:Any],Moya.Method)
    case socketToken(String,[String:Any],Moya.Method)
    
}
extension NT_API: TargetType {

    var baseURL: URL{
        
        switch self {
        case .normalRequest(_,_,_):
            return URL(string:NT_BASE_API)!
        case .uploadRequest(_,_, _,_):
            return URL(string:NT_BASE_API)!
        case .imNormalRequest(_, _, _):
            return URL(string:NT_BASE_API)!
        case .socketToken(_, _, _):
            return URL(string:NT_BASE_API)!
        }
    }

    var path: String{
        switch self {
        case .normalRequest(let api,_,_):
            return api
        case .uploadRequest(let api,_, _,_):
            return api
        case .imNormalRequest(let api, _, _):
            return api
        case .socketToken(let api, _, _):
            return api
        }
    }

    var method: Moya.Method{
        switch self {
        case .normalRequest(_,_,let method):
            return method
        case .uploadRequest(_, _,_,let method):
            return method
        case .imNormalRequest(_, _, let method):
            return method
        case .socketToken(_, _, let method):
            return method
        }
    }

    var sampleData: Data{
        return "sampleData".data(using: String.Encoding.utf8)!
    }

    var task: Task{
        var p:[String:Any]?
        var t:Task?
        var a:String = ""
        switch self {
        case .normalRequest(let api,let params,let method):
            p = params
            a = api
            if method == .post{
                t = .requestParameters(parameters: params, encoding: JSONEncoding.default)
            }else{
                t = .requestParameters(parameters: params, encoding: URLEncoding.default)
            }
        case .uploadRequest(_,let data, let params,_):
            p = params
            t = .uploadCompositeMultipart(data, urlParameters: params)
        case .imNormalRequest(let api,let params,let method):
            p = params
            a = api
            if method == .post{
                t = .requestParameters(parameters: params, encoding: JSONEncoding.default)
            }else{
                t = .requestParameters(parameters: params, encoding: URLEncoding.default)
            }
        case .socketToken(let api,let params,let method):
            p = params
            a = api
            if method == .post{
                t = .requestParameters(parameters: params, encoding: JSONEncoding.default)
            }else{
                t = .requestParameters(parameters: params, encoding: URLEncoding.default)
            }
        }
        NSLog("===请求:" + a + "参数:\(p!)")
        return t!
    }

    var headers: [String : String]?{
        let language = HCLocalizableManager.share.systemLanguage();
        var header = [
            "IP":NT_NetworkHelper.getClientIp(),
            "DEVICE-ID":NT_NetworkHelper.getDeviceName_OS(),
            "APP-VERSION":NT_NetworkHelper.getAppVersion(),
            "CHANNEL":"IOS",
            "AUTH-TOKEN":NT_NetworkHelper.getAuthToken(),
            "lang": language //"zh_cn"
        ]
        switch self {
        case .normalRequest(_,_,_):
            break
        case .uploadRequest(_, _,_,_):
            break
        case .imNormalRequest(_, _, _):
            break
        case .socketToken(_, _, _):
            
        header = [
            "CLIENT-IP":NT_NetworkHelper.getClientIp(),
            "DEVICE-ID":NT_NetworkHelper.getDeviceName_OS(),
            "APP-VERSION":NT_NetworkHelper.getAppVersion(),
            "CHANNEL":"IOS",
            "AUTH-TOKEN":NT_NetworkHelper.getAuthToken(),
            "lang": language, //"zh_cn"
            "sign": NT_NetworkHelper.getSign(),
            "time":Date.stringDate()
            ]
            break
        }
        NSLog("===请求头:\(header)")
        return header
    }
}
