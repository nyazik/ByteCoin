
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegirovaniye dlya scroll view datasource
        currencyPicker.dataSource = self
        
        //delegirovaniye dlya scroll view delegate 
        currencyPicker.delegate = self
        
        //delegirovaniye s drugogo controllera
        coinManager.delegate = self
    }


}
//MARK:- UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    
}
//MARK:- UIPickerViewDelegate
extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
    
}
//MARK:- CoinManagerDelegate
extension ViewController:CoinManagerDelegate{
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
