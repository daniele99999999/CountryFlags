// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphQLCountryFlags

public class Country: MockObject {
  public static let objectType: Object = GraphQLCountryFlags.Objects.Country
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Country>>

  public struct MockFields {
    @Field<String>("capital") public var capital
    @Field<GraphQLCountryFlags.ID>("code") public var code
    @Field<Continent>("continent") public var continent
    @Field<String>("currency") public var currency
    @Field<String>("emoji") public var emoji
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Country {
  convenience init(
    capital: String? = nil,
    code: GraphQLCountryFlags.ID? = nil,
    continent: Mock<Continent>? = nil,
    currency: String? = nil,
    emoji: String? = nil,
    name: String? = nil
  ) {
    self.init()
    self.capital = capital
    self.code = code
    self.continent = continent
    self.currency = currency
    self.emoji = emoji
    self.name = name
  }
}
