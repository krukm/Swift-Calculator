import UIKit

class ViewController: UIViewController {
    
    var operatorSelected: Bool = false
    var firstNum: Double?
    var secondNum: Double?
    var op: String?
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func digitAction(_ sender: UIButton) {
        let digit = (sender.titleLabel?.text)
        if display.text == " " {
            display.text = digit!
        } else {
            display.text = display.text! + digit!
        }
        print("digitAction: \(digit)")
        
        if !operatorSelected {
            firstNum = Double(display.text!)!
        } else {
            secondNum = Double(display.text!)!
        }
    }
    
    
    @IBAction func clearAction(_ sender: AnyObject) {
        print("clearAction")
        display.text = " "
    }
    @IBAction func operateAction( _ sender: UIButton) {
        if firstNum == nil {
            let alertController = UIAlertController(title: "Empty Operand Error", message: "Error: operand1 is empty", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            op = sender.titleLabel?.text
            display.text = " "
            operatorSelected = true
            print("operateAction: \(op)")
        }
    }
    @IBAction func equalsAction( _ sender: AnyObject) {
        print("equalsAction")
        
        if op == "√" {
            if firstNum! < 0.0 {
                let alertController = UIAlertController(title: "Sqrt Error", message: "Error: operand1 must be >= 0", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
                
            } else {
                display.text = doCalculation(operator1: op!, temp1: firstNum!, temp2: 0.0)
            }
            
        } else if secondNum == nil {
            let alertController = UIAlertController(title: "Empty Operand Error", message: "Error: operand2 is empty", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else if op == "/" && secondNum == 0.0 {
            let alertController = UIAlertController(title: "Divide by 0 Error", message: "Error: cannot divide by 0", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            
        } else {
            display.text = doCalculation(operator1: op!, temp1: firstNum!, temp2: secondNum!)
        }
        operatorSelected = false
        firstNum = nil
        secondNum = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = " "
        // Do any additional setup after loading the view, typically from a nib.
    }
}
