import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        loadData()
        
    }
    private func loadData() {
        NetworkManager.shared
            .callRequest(api: .usd) { (data: ExchangeRateData) in
                print(data)
                if let krwRate = data.rates["KRW"] {
                    print("USD -> KRW : \(krwRate)")
                }
            } failHandler: {
                print("Fail")
            }
    }
}
