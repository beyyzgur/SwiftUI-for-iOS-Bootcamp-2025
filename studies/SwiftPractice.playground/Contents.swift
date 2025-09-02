import Cocoa

    let customerName = "beyzos"
    var age = 21
    let height = 1.63
    var control = false
    
    print("Hello, I am \(customerName)")
    print("I'm \(age) years old")
    
    // Optional
    // Nullable - Null Safety
    var str = "Hello"
    
    var message: String?
    //  veya
    var message2: String? = nil

if message != nil {
    print(message!) // unwrapping
} else {
    print("error")
}

// Optional Binding
//let temp = message // Burada message nil ise ifade total olarak false olur

if let temp = message {
    print(temp) // otomatik unwrapping
} else {
    print("message is nil")
}

if var temp = message {
    temp = "Updated Message"
    print(temp) // otomatik unwrapping
} else {
    print("message is nil")
}

// Object Oriented
// Class - Object
class Product {
    var id: Int?
    var name: String?
    var price: Double?
    
    init(id: Int? = nil, name: String? = nil, price: Double? = nil) {   // self bulundugumuz sınıfı isaret eder.
        self.id = id // Global = local --> Shadowing
        self.name = name
        self.price = price
        
        print("init worked")
        // Bu sınıftan nesne oluşturulduğunda çalışır.
    }
}

var product1 = Product(id: 1, name: "TV", price: 39999.0)

print(product1.id!)
print(product1.name!)
print(product1.price!)

var product2 = Product(id: 2, name: "Laptop", price: 78000.0)

print(product2.id!)
print(product2.name!)
print(product2.price!)

