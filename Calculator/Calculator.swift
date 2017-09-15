import Foundation

class Calculator {
    var calculator_type = "Decimal"
    var operand_definition = "0, 1, 2, .... 8, 9"
    var keyboard : DgdScanner?
    
    // If we don't add any initializers to our binary, hex, and Roman
    //   calculators, then the following initializers will be available.
    
    init(){
        // Using the Keyboard
        keyboard = DgdScanner()
        common_init()
    }
    
    init(homework_dir: String, path: String){
        // This file better be there or else we will crash!!!!
        //   If this works then our "keyboard" input will be read from
        //   the specified file.  In the Linux/Unix world this is called
        //   "input redirection"
        
        keyboard = DgdScanner(homework_dir: homework_dir, path: path)
        common_init()
    }
    func common_init(){
        // place for common inititialization
    }
    
    // *********************
    //  The following methods will be overridden
    //  to create the Binary, Hex, and Roman Calculators
    // *********************
    
    func convert_to_decimal(_ operand_value: String)->Int{
        // Because we have sanity checked this with
        // validate_operand we can be bold here!!
        return Int(operand_value)!
    }
    func convert_from_decimal(_ value: Int) -> String{
        return "\(value)"
    }
    
    // Make sure all of the operands that are input are
    // valid integers
    
    func validate_operand(_ operand_value: String) -> Bool {
        for c in operand_value.characters {
            switch c {
            case "0","1","2","3","4","5","6","7","8","9":
                break
            default:
                print("***** Found a bad \(calculator_type) value in \(operand_value)")
                return false
            }
        } // end of for loop
        return true // Good operand_value
    }
    
    // Once we have the operator, and the 2 operands we can calculate
    func calculate(_ cmd: String, operand1: String, operand2: String) ->String{
        
        var answer : String
        switch(cmd){
        case "+":
            answer = add(operand1, operand2)
        case "-":
            answer = subtract(operand1, operand2)
        case "*":
            answer = multiply(operand1, operand2)
        case "/":
            answer = divide(operand1, operand2)
        default:
            answer = "Illegal operator ... This shouldn't happen"
        }
        return answer
    }
    
    
    func add(_ operand1: String, _ operand2: String)->String {
        let answer = convert_to_decimal(operand1) + convert_to_decimal(operand2)
        return convert_from_decimal(answer)
    }
    func subtract(_ operand1: String, _ operand2: String)->String {
        let answer = convert_to_decimal(operand1) - convert_to_decimal(operand2)
        return convert_from_decimal(answer)
    }
    func multiply(_ operand1: String, _ operand2: String)->String {
        let answer = convert_to_decimal(operand1) * convert_to_decimal(operand2)
        return convert_from_decimal(answer)
    }
    func divide(_ operand1: String, _ operand2: String)->String {
        let answer = convert_to_decimal(operand1) / convert_to_decimal(operand2)
        return convert_from_decimal(answer)
    }
    
    // Make sure we get a good operand.  Call validate_operand to make sure
    //   Ask again if the operand was bad.
    func get_operand (_ which : Int) ->String{
        repeat
        {
            print("Enter in operand: \(which) ... Can only contain:[ \(operand_definition) ]")
            if let operand_value = keyboard!.next() {
                if validate_operand(operand_value){
                    return operand_value
                }
                
            } else {
                print(" Keyboard is broken!!") // This Shouldn't happen
            }
        } while true
    }
    
    // Once we know the operator, this function is called to
    // collect the operands and print out the result
    func do_calculation(_ cmd: String) {
        let operand1 = get_operand(1)
        let operand2 = get_operand(2)
        let  answer = calculate(cmd, operand1: operand1, operand2: operand2)
        
        
        print("\(calculator_type):  \(answer) = \(operand1) \(cmd) \(operand2)", terminator: "   ... Integer Version: ")
        print(" \(convert_to_decimal(answer)) = \(convert_to_decimal(operand1)) \(cmd) \(convert_to_decimal(operand2))")
        
    }
    
    // Continue using the calculator until the user types in "quit"
    func run_loop(){
        print ("Welcome to my \(calculator_type) Calculator")
        var keep_running = true
        
        
        while keep_running {
            print("enter one of the following commands: [+ - * /  quit ]")
            
            // Note we should never see "broken" ... we are just making
            // the compiler happy with the optional value
            let cmd = keyboard!.next() ?? "broken"
            
            var operator_is_good = false
            
            switch cmd {
            case "+", "-", "*", "/":
                operator_is_good = true
            case "quit":
                keep_running = false
                print("Bye ... Thanks for using my \(calculator_type)  Calculator")
            default:
                print("##### Bad Operator Input: \(cmd)")
            }
            
            if operator_is_good {
                do_calculation(cmd)
            }
            
        } // End of while loop
        
    } // End of run_loop function
} // End of class
