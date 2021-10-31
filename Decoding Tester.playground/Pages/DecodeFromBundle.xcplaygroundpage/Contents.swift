import Foundation
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 
 ## Decoding JSON from a Bundled File
 You can use this playground page to test decoding of JSON to Codable structs from a file stored in the application bundle.
 
 In the **Sources** folder for this entire playground book there is an extension to Bundle that makes the process easier.
> Upload your json file to the **Resources** folder for this single playground.

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
 ### Decode your JSON on the next line making sure you use the correct model or array of model objects to decode as well as the correct name for the json file
 ```
 var users = Bundle.main.decode([User].self, from: "Users.json")
 ```
 */
var users = Bundle.main.decode([User].self, from: "Users.json")
/*:
### Test in the lines following
 ```
 print(users.count)
 for user in users {
     print(user.name)
     print(user.address.city)
     print("----------------")
 }
 ```
 */
print(users.count)
for user in users {
    print(user.name)
    print(user.address.city)
    print("----------------")
}

