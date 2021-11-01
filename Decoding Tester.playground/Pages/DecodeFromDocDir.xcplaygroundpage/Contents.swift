import Foundation
/*:
 [< Previous](@previous)           [Home](Introduction)
 
 ## Decoding JSON from a File in the Documents Directory
 You can use this playground page to test decoding of JSON to Codable structs from a file stored in the application's Document Directory.
 
 In the **Sources** folder for this entire playground book there is an extension to FileManager that makes the process easier.

 > You will need to upload a file to the Playground's **document Directory**.
 
 You can locate the directory by printing out its path
 
 `print(FileManager.docDirPath)`
 */
print(FileManager.docDirPath)
/*:
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
 ### Decode your JSON on the next line making sure you use the correct model or array of model objects to decode as well as the correct name for the json file.
 ```
 var users = FileManager.decode([User].self, from: "Users.json")
 ```
 */
var users = FileManager.decode([User].self, from: "Users.json")
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
    print("------------------")
}
