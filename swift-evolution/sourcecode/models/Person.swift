import UIKit

typealias People = [Person]

struct Person: Decodable {
    var id: String?
    let name: String?
    let link: String?
    let username: String?

    // These properties will not come from server
    var github: GithubProfile?
    var asAuthor: [Proposal]?
    var asManager: [Proposal]?
    
    enum Keys: String, CodingKey {
        case id
        case name
        case link
    }
    
}

extension Person: Searchable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.username = GithubUserFormatter.format(unboxedValue: self.link)
    }
    
}
