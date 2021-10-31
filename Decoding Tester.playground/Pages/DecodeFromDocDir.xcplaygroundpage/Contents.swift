import Foundation
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 
 ## Decoding JSON from a File in Documents Directory
 You can use this playground page to test decoding of JSON from a file stored in the application Document Direcgtory to Codable structs.
 
 In the **Sources** folder for this entire playground book there is an extension to FileManager that makes the process easier

 You will need to upload a file to the Playground's **document Directory**.
 You can locate the directory by printing out its path
 
 `print(FileManager.docDirPath)`
 */
print(FileManager.docDirPath)
/*:
 #### Start by entering your model below
*/
struct University: Codable {
  let alphaTwoCode: String
  let webPages: [URL]
  let name: String
  let country: String
  let domains: [String]
  let stateProvince: String?

  private enum CodingKeys: String, CodingKey {
    case alphaTwoCode = "alpha_two_code"
    case webPages = "web_pages"
    case name
    case country
    case domains
    case stateProvince = "state-province"
  }
}
/*:
 ### Decode your JSON on the next line making sure you use the correct model or array of model objects to decode as well as the correct name for the json file
 ```
 var users = Bundle.main.decode([User].self, from: "Users.json")
 ```
 */
var universities = FileManager.decode([University].self, from: "Universities.json")
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
print(universities.count)
for university in universities.filter({$0.domains.count > 1}) {
    print("\(university.name) has \(university.domains.count) domains")
}


