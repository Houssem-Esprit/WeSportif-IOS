

import Foundation
import UIKit

extension IMCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
         cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            guard  let iMCCell = tableView.dequeueReusableCell(withIdentifier: imcCellIdentifier, for: indexPath) as? IMCCell else { return UITableViewCell() }
            iMCCell.imcLabel.text = "\(self.imc)"
            cell = iMCCell
        default:
            guard  let chartCell = tableView.dequeueReusableCell(withIdentifier: chartCellIdentifier, for: indexPath) as? ChartCell else { return UITableViewCell() }
            cell = chartCell
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size: CGFloat?
        if indexPath.row == 0 {
             size =  UIScreen.main.bounds.height * 0.2
        } else {
             size = UIScreen.main.bounds.height * 0.3
        }
        return size!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: self.segueImc, sender: self)
        }
    }
    
    func getImcFromWS() {
        ApiManager.shared.getImc { (response) in
            debugPrint(response, "imc")
            self.imcElement = response?.imcs?.last
            
        }
    }
    
}
