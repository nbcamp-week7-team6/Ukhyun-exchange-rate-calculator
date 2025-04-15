import Foundation
import Alamofire

enum ExchangeRate {
    case krw
    case usd
    case jpy
    
    var baseURL: String {
        return "https://open.er-api.com/v6/latest/"
    }
    
    var endPoint: URL {
        switch self {
        case .krw:
            return URL(string: baseURL + "KRW")!
        case .usd:
            return URL(string: baseURL + "USD")!
        case .jpy:
            return URL(string: baseURL + "JPY")!
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest<T: Decodable>(api: ExchangeRate,
                                   completionHandler: @escaping (T) -> Void, failHandler: @escaping () -> Void) {
        AF.request(api.endPoint)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
                
            case .success(let success):
                print("통신 성공")
                completionHandler(success)
            case .failure(_):
                failHandler()
                let statusCode = response.response?.statusCode
                let msg = self.missedStatusCode(statusCode: statusCode)
                print(msg)
                print("통신 에러")
            }
        }
        
    }
    private func missedStatusCode(statusCode: Int?) -> String {
        guard let code = statusCode else { return "네트워크 오류 발생" }
        /*
         400 - Bad Request    The request was unacceptable, often due to missing a required parameter
         401 - Unauthorized    Invalid Access Token
         403 - Forbidden    Missing permissions to perform request
         404 - Not Found    The requested resource doesn’t exist
         500, 503    Something went wrong on our end
         */
        switch code {
        case 400:
            return "Bad Request - The request was unacceptable, often due to missing a required parameter"
        case 401:
            return "Unauthorized - Invalid Access Token"
        case 403:
            return "Forbidden - Missing permissions to perform request"
        case 404:
            return "Not Found - The requested resource doesn’t exist"
        case 500,503:
            return "Something went wrong on our end"
        default:
            return "네트워크 오류 발생."
        }
    }
}
