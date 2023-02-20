// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CountryDetailQuery: GraphQLQuery {
  public static let operationName: String = "CountryDetail"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query CountryDetail($code: ID!) {
        country(code: $code) {
          __typename
          continent {
            __typename
            name
          }
          capital
          currency
        }
      }
      """#
    ))

  public var code: ID

  public init(code: ID) {
    self.code = code
  }

  public var __variables: Variables? { ["code": code] }

  public struct Data: GraphQLCountryFlags.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { GraphQLCountryFlags.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("country", Country?.self, arguments: ["code": .variable("code")]),
    ] }

    public var country: Country? { __data["country"] }

    /// Country
    ///
    /// Parent Type: `Country`
    public struct Country: GraphQLCountryFlags.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { GraphQLCountryFlags.Objects.Country }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("continent", Continent.self),
        .field("capital", String?.self),
        .field("currency", String?.self),
      ] }

      public var continent: Continent { __data["continent"] }
      public var capital: String? { __data["capital"] }
      public var currency: String? { __data["currency"] }

      /// Country.Continent
      ///
      /// Parent Type: `Continent`
      public struct Continent: GraphQLCountryFlags.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { GraphQLCountryFlags.Objects.Continent }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("name", String.self),
        ] }

        public var name: String { __data["name"] }
      }
    }
  }
}
