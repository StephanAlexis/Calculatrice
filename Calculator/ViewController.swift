//
//  ViewController.swift
//  Calculator
//
//  Created by Jean Stephane Alexis on 4/7/18.
//  Copyright © 2018 MBDS. All rights reserved.
//

import UIKit
import Darwin

enum lesTagsDesBoutons: Int{
    case zero=0
    case un
    case deux
    case trois
    case quatre
    case cinq
    case six
    case sept
    case huit
    case neuf
    case addition
    case soustraction
    case multiplication
    case division
    case point
    case egale
    case backspace
    case pourcentage
    case clearAll
    case ln
    case log
    case squareroot
    case cos
    case sin
    case tan
}

class Calculette{
    var premierNombre: String="0"
    var NombreAFormater: String="0"
    var operationAFaire: Int?
    var SecondNombreReference: Bool?
    
    func tagNombre(_ tag: Int)->String{
        let tempon="\(tag)"
        if(NombreAFormater=="0")
        {
            NombreAFormater=tempon
        }
        else
        {
            NombreAFormater+=tempon
        }
        return NombreAFormater
    }
    func tagDecimal()->String{
        if(NombreAFormater.range(of: ".")==nil)
        {
            NombreAFormater+="."
        }
        return NombreAFormater
    }
    func tagBackspace()->String{
        if(NombreAFormater.count>1)
        {
            NombreAFormater.remove(at: NombreAFormater.index(before: NombreAFormater.endIndex))
        }
        else
        {
            NombreAFormater="0"
        }
        return NombreAFormater
        
    }
    func tagLn()->String{
        return "\(log((NombreAFormater as NSString).doubleValue))"
    }
 /*   func tagLog()->String
    {
        return "\(ln((NombreAFormater as NSString).doubleValue))"
    }*/
    func tagSquareRoot()->String
    {
        return "\(sqrt((NombreAFormater as NSString).doubleValue))"
    }
    //func tag
    func tagOperation(tag: Int)->String{
        if(operationAFaire==nil)
        {
            operationAFaire=tag
            premierNombre=NombreAFormater
            NombreAFormater="0"
        }
        else
        {
            premierNombre="\(tagEgale())"
            NombreAFormater="0"
            operationAFaire=tag
        }
        return NombreAFormater
        
    }
    
    func getOperation()->String
    {
        if(operationAFaire != nil){
            switch(operationAFaire!)
            {
            case lesTagsDesBoutons.addition.rawValue:
                return "+"
            case lesTagsDesBoutons.soustraction.rawValue:
                return "-"
            case lesTagsDesBoutons.multiplication.rawValue:
                return "x"
            case lesTagsDesBoutons.division.rawValue:
                return "/"
            default:
                return ""
            }
        }
        return ""
    }
    func tagEgale()->String
    {
        //if(Nombre)
        let a=(premierNombre as NSString).doubleValue
        let b=(NombreAFormater as NSString).doubleValue
        switch(operationAFaire!)
        {
            case lesTagsDesBoutons.addition.rawValue:
                NombreAFormater="\(a+b)"
                operationAFaire=nil
                return NombreAFormater
            case lesTagsDesBoutons.soustraction.rawValue:
                NombreAFormater="\(a-b)"
                operationAFaire=nil
                return NombreAFormater
            case lesTagsDesBoutons.multiplication.rawValue:
                NombreAFormater="\(a*b)"
                operationAFaire=nil
                return NombreAFormater
            case lesTagsDesBoutons.division.rawValue:
                NombreAFormater="\(a/b)"
                operationAFaire=nil
                return NombreAFormater
            default:
                return ""
        }
    }
    func tagPourcentage(){
        if (operationAFaire != nil)
        {
            NombreAFormater = "\((premierNombre as NSString).doubleValue * (NombreAFormater as NSString).doubleValue / 100)"
        }
    }
    func tagReset()
    {
        premierNombre="0"
        NombreAFormater="0"
        operationAFaire=nil
        
    }
}


class ViewController: UIViewController {
    
    var calcul: Calculette=Calculette()
    
    
    @IBOutlet weak var labelResultat: UILabel!
    @IBOutlet weak var labelEntree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeSuffix(_ unString:String)->String
    {
        let str=unString.suffix(2)
        if(str==".0")
        {
            return "\(unString.prefix(unString.count-2))"
        }
        else
        {
            return unString
        }
    }
    @IBAction func btnClick(_ sender: UIButton) {
        let tag=sender.tag
        switch(tag)
        {
        case (lesTagsDesBoutons.zero.rawValue) ... (lesTagsDesBoutons.neuf.rawValue):
            labelEntree.text = calcul.tagNombre(tag)
            break
        case lesTagsDesBoutons.point.rawValue:
            labelEntree.text=calcul.tagDecimal()
            break
        case lesTagsDesBoutons.backspace.rawValue:
            labelEntree.text=calcul.tagBackspace()
            break
        case (lesTagsDesBoutons.addition.rawValue)...(lesTagsDesBoutons.multiplication.rawValue):
            labelEntree.text=calcul.tagOperation(tag: tag)
            labelResultat.text=calcul.premierNombre + calcul.getOperation()
            break
        case lesTagsDesBoutons.egale.rawValue:
            if(calcul.operationAFaire != nil){
                labelResultat.text=calcul.premierNombre+calcul.getOperation()+calcul.NombreAFormater
                labelEntree.text=removeSuffix(calcul.tagEgale())
            }
            break
        case lesTagsDesBoutons.pourcentage.rawValue:
            calcul.tagPourcentage()
            labelResultat.text=calcul.premierNombre + calcul.getOperation() + calcul.NombreAFormater
            labelEntree.text=removeSuffix(calcul.tagEgale())
            break
        case lesTagsDesBoutons.clearAll.rawValue:
            calcul.tagReset()
            labelResultat.text=""
            labelEntree.text="0"
            break
        default:
            break
        }
    }
    
    @IBOutlet weak var lblResultat: UILabel!
    
    @IBOutlet weak var lblEntree: UILabel!
    
    
    @IBAction func btn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func btnClick2(_ sender: UIButton) {
               let tag=sender.tag
        switch(tag)
        {
        case (lesTagsDesBoutons.zero.rawValue) ... (lesTagsDesBoutons.neuf.rawValue):
            lblEntree.text = calcul.tagNombre(tag)
            break
        case lesTagsDesBoutons.point.rawValue:
            lblEntree.text=calcul.tagDecimal()
            break
        case lesTagsDesBoutons.backspace.rawValue:
            lblEntree.text=calcul.tagBackspace()
            break
        case (lesTagsDesBoutons.addition.rawValue)...(lesTagsDesBoutons.multiplication.rawValue):
            lblEntree.text=calcul.tagOperation(tag: tag)
            lblResultat.text=calcul.premierNombre + calcul.getOperation()
            break
        case lesTagsDesBoutons.egale.rawValue:
            if(calcul.operationAFaire != nil){
                lblResultat.text=calcul.premierNombre+calcul.getOperation()+calcul.NombreAFormater
                lblEntree.text=removeSuffix(calcul.tagEgale())
            }
            break
        case lesTagsDesBoutons.pourcentage.rawValue:
            calcul.tagPourcentage()
            lblResultat.text=calcul.premierNombre + calcul.getOperation() + calcul.NombreAFormater
            lblEntree.text=removeSuffix(calcul.tagEgale())
            break
        case lesTagsDesBoutons.clearAll.rawValue:
            calcul.tagReset()
            lblResultat.text=""
            lblEntree.text="0"
            break
        default:
            break
        }
    }
    
    
}
