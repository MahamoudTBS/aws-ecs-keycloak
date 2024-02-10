FROM quay.io/keycloak/keycloak:20.0.5 as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange

# Configure a database vendor
ENV KC_DB=mysql

WORKDIR /opt/keycloak

RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.5

COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak

# configuring email listener to send emails for specific events
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start --optimized --spi-events-listener-email-include-events=verify_email,update_password,send_reset_password,send_verify_email,reset_password"]