from django.contrib.auth import authenticate
from rest_framework import serializers

from client.models import Client, DevClientInContact
from developer.models import Developer
from .models import User, PhoneOTP, City


class RegistrationSerializer(serializers.ModelSerializer):
    """
    Creates a new user.
    Email, username, and password are required.
    Returns a JSON web token.
    """

    # The password must be validated and should not be read by the client
    # password = serializers.CharField(
    #     max_length=128,
    #     min_length=8,
    #     write_only=True,
    # )

    # The client should not be able to send a token along with a registration
    # request. Making `token` read-only handles that for us.
    token = serializers.CharField(max_length=255, read_only=True)

    class Meta:
        model = User
        fields = ('email', 'phone', 'name', 'surname')

    def create(self, validated_data):
        return User.objects.create_user(**validated_data)


class LoginSerializer(serializers.Serializer):
    """
    Authenticates an existing user.
    Email and password are required.
    Returns a JSON web token.
    """
    email = serializers.EmailField(write_only=True)
    password = serializers.CharField(max_length=128, write_only=True)

    # Ignore these fields if they are included in the request.
    # username = serializers.CharField(max_length=255, read_only=True)
    # token = serializers.CharField(max_length=255, read_only=True)

    def validate(self, data):
        """
        Validates user data.
        """
        email = data.get('email', None)
        password = data.get('password', None)

        if email is None:
            raise serializers.ValidationError(
                'An email address is required to log in.'
            )

        if password is None:
            raise serializers.ValidationError(
                'A password is required to log in.'
            )

        user = authenticate(username=email, password=password)

        if user is None:
            raise serializers.ValidationError(
                'A user with this email and password was not found.'
            )

        if not user.is_active:
            raise serializers.ValidationError(
                'This user has been deactivated.'
            )

        return {
            'token': user.token,
        }


class OTPSerializer(serializers.Serializer):
    """
    Authenticates an existing user.
    Email and password are required.
    Returns a JSON web token.
    """
    phone = serializers.CharField(write_only=True)
    otp = serializers.CharField(max_length=128, write_only=True)

    # Ignore these fields if they are included in the request.
    # username = serializers.CharField(max_length=255, read_only=True)
    token = serializers.CharField(max_length=255, read_only=True)

    def validate(self, data):
        """
        Validates user data.
        """
        phone = data.get('phone', None)
        otp = data.get('otp', None)
        try:
            obj = PhoneOTP.objects.get(phone=phone, otp=otp)
            if phone is None:
                raise serializers.ValidationError(
                    'An phone address is required to log in.'
                )

            if otp is None:
                raise serializers.ValidationError(
                    'A OTP is required to log in.'
                )

            if obj is None:
                raise serializers.ValidationError(
                    'A user with this email and password was not found.'
                )

            # if not user.is_active:
            #     raise serializers.ValidationError(
            #         'This user has been deactivated.'
            #     )
            # PhoneOTP.objects.filter(phone=phone, otp=otp).update(token=key.token)
            obj.key_token = obj.token
            obj.save()
            return {
                'token': obj.token,
            }
        except:
            raise Exception('Phone credentials is false')


class PhoneOTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = PhoneOTP
        fields = ['phone', 'otp']


class CityTitleSerializer(serializers.BaseSerializer):

    def to_representation(self, instance):
        return instance.title

class PrivateField(serializers.ReadOnlyField):

    def get_attribute(self, instance):
        # print(instance)
        try:
            client = Client.objects.get(user=self.context['request'].user)
            contacts = DevClientInContact.objects.filter(client_id=client, dev_id__user=instance)
            try:
                for contact in contacts:
                    if contact.dev_perm == True:
                        return super(PrivateField, self).get_attribute(instance)
            except:
                return None
        except:
            return None

class UserFIOSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["name", "surname"]

class UserDevSerializer(serializers.ModelSerializer):
    city = CityTitleSerializer(read_only=True, many=False)
    class Meta:
        model = User
        fields = ["name", "surname", "birth_date", "gender", "role", "city", "phone"]

class UserSerializer(serializers.ModelSerializer):
    city = CityTitleSerializer(read_only=True, many=False)
    phone = PrivateField()
    # phone = serializers.SerializerMethodField("get_phone")
    class Meta:
        model = User
        fields = ["name", "surname", "birth_date", "gender", "role", "city", "phone"]

    def validate_phone(self, phone):
        if ['/', '.'] in phone:
            raise serializers.ValidationError('Not accepting character in phone')

    def get_phone(self, instance):
        try:
            if Developer.objects.get(user=self.context['request'].user):
                dev = Developer.objects.get(user=self.context['request'].user)
                if dev.user.email == self.context['request'].user.email:
                    return instance.phone
            try:
                client = Client.objects.get(user=self.context['request'].user)
            except Exception as e:
                return str(e)
            contacts = DevClientInContact.objects.filter(client_id=client, dev_id__user=instance)
            try:
                for contact in contacts:
                    if contact.dev_perm == True:
                        return instance.phone
            except Exception as e:
                raise str(e)
        except Exception as e:
            raise type(e)


class CitiesSerializer(serializers.ModelSerializer):
    class Meta:
        model = City
        fields = ['id', 'title']
