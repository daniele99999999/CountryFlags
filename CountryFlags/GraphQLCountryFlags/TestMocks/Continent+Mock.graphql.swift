// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphQLCountryFlags

public class Continent: MockObject {
  public static let objectType: Object = GraphQLCountryFlags.Objects.Continent
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Continent>>

  public struct MockFields {
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Continent {
  convenience init(
    name: String? = nil
  ) {
    self.init()
    self.name = name
  }
}
