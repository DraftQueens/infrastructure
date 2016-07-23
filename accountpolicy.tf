resource "aws_iam_account_password_policy" "long" {
    allow_users_to_change_password = true
    minimum_password_length = 24
    max_password_age = 180
    password_reuse_prevention = 4
    require_lowercase_characters = false
    require_uppercase_characters = false
    require_numbers = false
    require_symbols = false
}
 
