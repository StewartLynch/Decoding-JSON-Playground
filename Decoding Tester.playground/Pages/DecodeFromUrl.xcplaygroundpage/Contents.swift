import SwiftUI
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 
 ## Decoding JSON from a URL
 You can use this playground page to test decoding of JSON from a url, using an APIService class that has two getJSON methods.
 
 One of the methods uses async and await while the alternative uses a completion handler
 #### Start by entering your model below
*/
struct User: Codable {
  struct Address: Codable {
    struct Geo: Codable {
      let lat: String
      let lng: String
    }

    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
  }

  struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
  }

  let id: Int
  let name: String
  let username: String
  let email: String
  let address: Address
  let phone: String
  let website: String
  let company: Company
}
/*:
 ### Create an instance of the APIService, passing in the api url string
 ```
 let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
 ```
 */
let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
/*:
 ### Create an asynchronous Task to call the apiService.getJSON function or use the callback version
 ```
 Task {
     let users:[User] = try await apiService.getJSON()
     print(users.count)
     for user in users {
         print(user.name)
         print(user.address.city)
         print("----------------")
     }
 }
 ```
 OR
 ```
 apiService.getJSON { (users: [User]) in
     let users = users
     print(users.count)
     for user in users {
         print(user.name)
         print(user.address.city)
         print("----------------")
     }
 }
 ```
 */
// Async
Task {
    let users:[User] = try await apiService.getJSON()
    print(users.count)
    for user in users {
        print(user.name)
        print(user.address.city)
        print("----------------")
    }
}

// Completion Handler
apiService.getJSON { (users: [User]) in
    let users = users
    print(users.count)
    for user in users {
        print(user.name)
        print(user.address.city)
        print("----------------")
    }
}



