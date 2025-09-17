//
//  ToDos.swift
//  TickyProject
//
//  Created by beyyzgur on 17.09.2025.
//

import Foundation

class ToDos : Identifiable {
    var id:Int?
    var name:String?
    
    init(){
        
    }
    
    init(id: Int,name: String){
        self.id = id
        self.name = name
    }
}
