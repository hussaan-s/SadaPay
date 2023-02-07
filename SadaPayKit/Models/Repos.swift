
import Foundation

public struct Repos: Decodable {
    public let items: [Repo]
}

public struct Repo: Decodable {
    public let id: Int
    public let name: String
    public let owner: Owner
    public let description: String
    public let stargazersCount: Int
    public let language: String?
}


public struct Owner: Decodable {
    public let id: Int
    public let login: String
    public let avatarUrl: URL?
}
