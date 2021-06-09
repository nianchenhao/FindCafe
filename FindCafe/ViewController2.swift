//
//  ViewController2.swift
//  FindCafe
//
//  Created by 粘辰晧 on 2021/6/9.
//

import UIKit

class ViewController2: UIViewController{
    var cafes = [CafeInfo]()
    var pickerView = UIPickerView()
    
    let cities = ["taipei","yilan","taoyuan","hsinchu","miaoli","taichung","changhua","Nantou","Yunlin","Chiayi","Tainan","Kaohsiung","Pingtung"]
    let apiUrlString = "https://cafenomad.tw/api/v1.2/cafes"
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
        textField.textAlignment = .center
        textField.placeholder = "Select a City"
        
        let nib = UINib(nibName:"CafeTableViewCell", bundle: nil)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(nib,forCellReuseIdentifier:"CafeTableViewCell")
    }
    
    
    
    @IBAction func searchCity(_ sender: Any) {
        if let searchText = textField.text {
            let urlString = "\(apiUrlString)/\(searchText)"
            
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    let decoder = JSONDecoder()
                    
                    if let data = data, let cafeResult = try?decoder.decode([CafeInfo].self, from: data){
                        self.cafes = cafeResult
                        print(cafeResult)
                        print(self.cafes.count)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData() // TableView更新抓到的資料
                        }
                    }
                }.resume()
            }
            
        }
    }
}
extension ViewController2: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        let cafeInfo = cafes[indexPath.row]
        
        cell.cafeName.text = cafeInfo.name
        cell.cafeAddress.text = cafeInfo.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let vc = segue.destination as! DetailViewController
                vc.cafeData = cafes[indexPath.row]
                
            }
        }
    }
    
    
    
}

extension ViewController2: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = cities[row]
        textField.resignFirstResponder()
    }
}

