import Fluent

struct CreateWebauthnCredential: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("webAuthn_Credentials")
            .field("id", .string, .identifier(auto: false))
            .field("public_key", .string, .required)
            .field("current_signCount", .uint32, .required)
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .unique(on: "id")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("webAuthn_Credentials").delete()
    }
}

