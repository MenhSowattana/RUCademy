//  This file was automatically generated and should not be edited.

import AWSAppSync

public final class GetArticleQuery: GraphQLQuery {
  public static let operationString =
    "query GetArticle($id: ID!) {\n  getArticle(id: $id) {\n    __typename\n    id\n    title\n    author\n    description\n  }\n}"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getArticle", arguments: ["id": GraphQLVariable("id")], type: .object(GetArticle.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getArticle: GetArticle? = nil) {
      self.init(snapshot: ["__typename": "Query", "getArticle": getArticle.flatMap { $0.snapshot }])
    }

    public var getArticle: GetArticle? {
      get {
        return (snapshot["getArticle"] as? Snapshot).flatMap { GetArticle(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getArticle")
      }
    }

    public struct GetArticle: GraphQLSelectionSet {
      public static let possibleTypes = ["Article"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil, description: String? = nil) {
        self.init(snapshot: ["__typename": "Article", "id": id, "title": title, "author": author, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}

public final class AllArticlesQuery: GraphQLQuery {
  public static let operationString =
    "query AllArticles {\n  getArticles {\n    __typename\n    id\n    title\n    author\n    description\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getArticles", type: .list(.object(GetArticle.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getArticles: [GetArticle?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "getArticles": getArticles.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var getArticles: [GetArticle?]? {
      get {
        return (snapshot["getArticles"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { GetArticle(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "getArticles")
      }
    }

    public struct GetArticle: GraphQLSelectionSet {
      public static let possibleTypes = ["Article"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil, description: String? = nil) {
        self.init(snapshot: ["__typename": "Article", "id": id, "title": title, "author": author, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}

public final class AddArticleMutation: GraphQLMutation {
  public static let operationString =
    "mutation AddArticle($id: ID!, $title: String, $description: String, $author: String) {\n  insertArticle(id: $id, title: $title, description: $description, author: $author) {\n    __typename\n    id\n    title\n    author\n    description\n  }\n}"

  public var id: GraphQLID
  public var title: String?
  public var description: String?
  public var author: String?

  public init(id: GraphQLID, title: String? = nil, description: String? = nil, author: String? = nil) {
    self.id = id
    self.title = title
    self.description = description
    self.author = author
  }

  public var variables: GraphQLMap? {
    return ["id": id, "title": title, "description": description, "author": author]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("insertArticle", arguments: ["id": GraphQLVariable("id"), "title": GraphQLVariable("title"), "description": GraphQLVariable("description"), "author": GraphQLVariable("author")], type: .object(InsertArticle.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(insertArticle: InsertArticle? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "insertArticle": insertArticle.flatMap { $0.snapshot }])
    }

    public var insertArticle: InsertArticle? {
      get {
        return (snapshot["insertArticle"] as? Snapshot).flatMap { InsertArticle(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "insertArticle")
      }
    }

    public struct InsertArticle: GraphQLSelectionSet {
      public static let possibleTypes = ["Article"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil, description: String? = nil) {
        self.init(snapshot: ["__typename": "Article", "id": id, "title": title, "author": author, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}

public final class OnCreateArticleSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateArticle($author: String) {\n  subscribeToArticle(author: $author) {\n    __typename\n    id\n    author\n    title\n    description\n  }\n}"

  public var author: String?

  public init(author: String? = nil) {
    self.author = author
  }

  public var variables: GraphQLMap? {
    return ["author": author]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("subscribeToArticle", arguments: ["author": GraphQLVariable("author")], type: .object(SubscribeToArticle.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(subscribeToArticle: SubscribeToArticle? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "subscribeToArticle": subscribeToArticle.flatMap { $0.snapshot }])
    }

    public var subscribeToArticle: SubscribeToArticle? {
      get {
        return (snapshot["subscribeToArticle"] as? Snapshot).flatMap { SubscribeToArticle(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "subscribeToArticle")
      }
    }

    public struct SubscribeToArticle: GraphQLSelectionSet {
      public static let possibleTypes = ["Article"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("author", type: .scalar(String.self)),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, author: String? = nil, title: String? = nil, description: String? = nil) {
        self.init(snapshot: ["__typename": "Article", "id": id, "author": author, "title": title, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}