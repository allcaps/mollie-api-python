from .base import Base


class PaymentLink(Base):
    @classmethod
    def get_resource_class(cls, client):
        from ..resources.payment_links import PaymentLinks

        return PaymentLinks(client)

    @classmethod
    def get_object_name(cls):
        return "payment_links"

    # Documented properties

    @property
    def resource(self):
        return self._get_property("resource")

    @property
    def id(self):
        return self._get_property("id")

    @property
    def description(self):
        return self._get_property("description")

    @property
    def mode(self):
        return self._get_property("mode")

    @property
    def profile_id(self):
        return self._get_property("profileId")

    @property
    def amount(self):
        return self._get_property("amount")

    @property
    def redirect_url(self):
        return self._get_property("redirectUrl")

    @property
    def webhook_url(self):
        return self._get_property("webhookUrl")

    @property
    def created_at(self):
        return self._get_property("createdAt")

    @property
    def paid_at(self):
        return self._get_property("paidAt")

    @property
    def updated_at(self):
        return self._get_property("updatedAt")

    @property
    def expires_at(self):
        return self._get_property("expiresAt")

    # documented _links

    @property
    def payment_link(self):
        return self._get_link("paymentLink")

    # additional methods

    def is_paid(self):
        return self._get_property("paidAt") is not None

    def has_expiration_date(self):
        return self._get_property("expiresAt") is not None
