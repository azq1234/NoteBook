//
//  NT_NetWorkProvider.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
import Moya
var networkCount = 0
typealias NSuccess = () -> Void
typealias Success = (Any) -> Void
typealias Failure = (Any) -> Void

let p = NT_NetWorkProvider()

let queue = DispatchQueue(label: "requestCallBack", attributes: DispatchQueue.Attributes.concurrent)

class NT_NetWorkProvider: MoyaProvider<NT_API> {
    /// 初始化服务器配置-网络框架MoyaProvider
    init() {
        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                NSLog("===请求地址:" + request.url!.absoluteString)
                request.timeoutInterval = 60 //请求超时时间 10秒
                done(.success(request))
            } catch let error{
                done(.failure(MoyaError.underlying(error,nil)))
            }
        }
        super.init(requestClosure: requestClosure)
    }
    
    // 请求，target中封装了接口请求数据
    func request(_ target: NT_API,success:@escaping Success,fail failure:@escaping Failure) -> Cancellable {
        NSLog("CPT网络请求="+target.path);
        return self.request(target, callbackQueue: queue) { result in
            switch result {
            case let .success(response):
                NT_SystemTime.updateSystemTime(response: response.response)
                let result = NT_NetWorkResult()
                result.statusCode = response.statusCode
                if result.statusCode == 200 {
                    if let res = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? [String:Any] ?? [:] {
                        
                        result.storeData = res
                        guard let code = result.storeData?["code"] as? String , "200" == code  else {
                            // 出现错误
                            DispatchQueue.main.async {
                                let ep = NTError()
                                ep.errorCode = Int(result.storeData?["code"] as? String ?? "0") ?? 0
//
                                if ep.errorCode == 0 && target.path == "/v1/app/xxxxx"{
                                    success(res)
                                    return
                                }
//
                                if let errorStr: String = result.storeData?["error"] as? String, errorStr.count > 0 {
                                    ep.localizedDescription =  errorStr
                                }else if let msg :String = result.storeData?["msg"] as? String {
                                    ep.localizedDescription =  msg
                                }
                                if 401 == ep.errorCode {
                                    ep.localizedDescription = "登录过期"
                                }
                                if 403 == ep.errorCode {
                                    ep.localizedDescription = "没有相应的权限"
                                }
//                                // 返回错误信息
                                failure(ep)
                            }
                            return
                        }
                        // 返回数据
                        DispatchQueue.main.async {

                            if target.path == "指定IP" {
                                success(res["data"]!)
                            }else{
                                success(result)
                            }
                        }
                    } else {
                        // 反回数据非 JSON类型, 作其他处理
                        otherRequest(response: response, success: success, fail: failure)
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = NTError()
                        error.errorCode = result.statusCode!
                        failure(error)
                    }
                }
            case let .failure(error):
                let nterror = NTError()
                nterror.errorCode = error.errorCode
                nterror.localizedDescription = error.errorDescription ?? ""
                if nterror.localizedDescription.contains(find: "URLSessionTask failed with error:")
                {
                    DispatchQueue.main.async {
                        NT_Maintain.startMaintain()
                    }
                }
                failure(nterror)
            }
        }
    }
}


func otherRequest(response: Response, success:@escaping Success,fail failure:@escaping Failure) {
    guard let urlStr = response.request?.url?.absoluteString  else {
        DispatchQueue.main.async { failure(NTError()) }
        NSLog ("-----请求地址不详")
        return
    }
    if urlStr.contains(find: "xxxxx") && response.data.count > 0  { // 具体路经具体处理
        DispatchQueue.main.async {  success(response.data) }
        return
    }
    
    let error = NTError()
    error.errorCode = 10001
    DispatchQueue.main.async {
        failure(error)
    }
}

class NTError: CustomNSError {
    var errorCode: Int = 0 {
        didSet {
            
            if 401 == errorCode {
                
                
                //                guard  != nil else { return } // 判断用户是否登录
                
                DispatchQueue.main.async {
                    //
                    //                   操作退出登录
                    //
                    //                   展示登录逻辑UI
                    //
                }
            }
            if 504 == errorCode {
                localizedDescription = "网络请求超时"
            }
            
            if 9999 == errorCode {              // 系统升级维护
                NT_Maintain.startMaintain()
            }
        }
    }
    var localizedDescription: String = ""
    
    class func parseError() -> NTError {
        let e = NTError()
        e.errorCode = 7777
        e.localizedDescription = "数据解析错误"
        return e
    }
}
