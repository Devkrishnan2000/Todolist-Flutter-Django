from rest_framework_simplejwt.tokens import RefreshToken


class Validation:
    @staticmethod
    def name_validation():
        return r"^(?=.*[A-Za-z])[A-Za-z\s]+$"

    @staticmethod
    def password_validation():
        return r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>])[A-Za-z\d!@#\$%^&*()_+]{8,20}$"


class ErrorHandling:
    def error_message_handling(self, error):
        first_value = next(iter(error.values()))
        error_data = first_value[0].split("+")
        return {"error_message": error_data[0], "error_code": error_data[1]}


class Token:
    def generate_token(self, user):
        refresh_token = RefreshToken.for_user(user)
        return {
            "refresh": str(refresh_token),
            "access": str(refresh_token.access_token),
            "refresh_token_expire_time": str(
                refresh_token.lifetime.total_seconds() * 1000
            ),
        }
