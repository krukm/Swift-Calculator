import Foundation

func doCalculation(operator1: String, temp1: Double, temp2: Double) -> String {
    var answer: Double = 0
    
    switch operator1 {
    
    case "+":
    answer = temp1 + temp2
    
    case "-":
    answer = temp1 - temp2
    
    case "*":
    answer = temp1 * temp2
    
    case "/":
    if ((temp1 == 0) || (temp2 == 0)) {
    answer = 0
    } else {
    answer = temp1 / temp2
    }
    
    case "√":
    if ((temp1 == 0)) {
    answer = 0
    } else {
    answer = sqrt(temp1)
    }
    default:
        print("What happened?")
    }
    return String(answer)
}
