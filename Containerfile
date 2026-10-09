FROM registry.access.redhat.com/ubi10/ubi-minimal@sha256:bcecd3e74c9d03eb1a596c6c8f366775a289d422ac5925ec1539924d762ebf23 AS build

RUN microdnf install -y gzip tar gnupg2 && microdnf clean all

WORKDIR /build
COPY scripts/download-and-verify-tools.sh .
RUN ./download-and-verify-tools.sh

FROM registry.access.redhat.com/ubi10/ubi-minimal@sha256:bcecd3e74c9d03eb1a596c6c8f366775a289d422ac5925ec1539924d762ebf23

LABEL org.opencontainers.image.source="https://github.com/InHolland-Cloud-Minor-2627/img-okd-tools" \
      org.opencontainers.image.description="Runs a OKD client in a container"

RUN microdnf install -y procps-ng jq && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/
COPY kubeconform /usr/local/share/kubeconform/
