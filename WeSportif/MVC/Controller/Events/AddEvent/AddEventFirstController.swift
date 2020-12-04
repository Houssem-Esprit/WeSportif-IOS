

import UIKit

class AddEventFirstController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var eventDateTF: UITextField!
    @IBOutlet weak var eventNameTF: UITextField!
    private var datePicker: UIDatePicker?
    var catArray : [Cat]? = [] {
        didSet {
            catArray?.forEach({ (categ) in
                typesArray.append(categ.nom)
              
            })
              self.pickerView.reloadAllComponents()
        }
    }
    var selectedIndex = 0
    var typesArray: [String] = []
    
    let nextPageSegueId = "nextPage"
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        showCalendarInTF()
        initCategories()
        
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func showCalendarInTF() {
        eventDateTF.delegate = self
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(selectDate(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        self.view.addGestureRecognizer(tapGesture)
        eventDateTF.inputView = datePicker
    }
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    
    @objc func selectDate(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        
        eventDateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if let eventDate = eventDateTF.text, !eventDate.isEmpty, let eventName = eventNameTF.text, !eventName.isEmpty {
             performSegue(withIdentifier: nextPageSegueId, sender: self)
        }
       
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension AddEventFirstController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typesArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = catArray?[row].idCat ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nextPageSegueId {
            if let secondVC = segue.destination as? AddEventSecondController {
              secondVC.nomCategory = eventNameTF.text ?? ""
                secondVC.dateEvent = eventDateTF.text ?? ""
                secondVC.catId = selectedIndex
                
            }
        }
    }
    
    func initCategories () {
        ApiManager.shared.getACategoriesWS { (categ) in
            self.catArray = categ?.cats
        }
    }
}
