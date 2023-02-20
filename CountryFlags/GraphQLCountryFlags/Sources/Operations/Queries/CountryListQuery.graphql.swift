// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CountryListQuery: GraphQLQuery {
  public static let operationName: String = "CountryList"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query CountryList {
        countries {
          __typename
          code
          name
          emoji
        }
      }
      """#
    ))

  public init() {}

  public struct Data: GraphQLCountryFlags.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { GraphQLCountryFlags.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("countries", [Country].self),
    ] }

    public var countries: [Country] { __data["countries"] }

    /// Country
    ///
    /// Parent Type: `Country`
    public struct Country: GraphQLCountryFlags.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { GraphQLCountryFlags.Objects.Country }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("code", GraphQLCountryFlags.ID.self),
        .field("name", String.self),
        .field("emoji", String.self),
      ] }

      public var code: GraphQLCountryFlags.ID { __data["code"] }
      public var name: String { __data["name"] }
      public var emoji: String { __data["emoji"] }
    }
  }
}
