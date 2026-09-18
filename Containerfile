FROM registry.access.redhat.com/ubi10/ubi-minimal@sha256:04febb4a74cc9ef3eca05ef851d92957276cc6e82fe8cb1ee44abf5114d440d8 AS build

RUN microdnf install -y gzip tar gnupg2 && microdnf clean all

ADD scripts/download-and-verify-tools.sh .
RUN ./download-and-verify-tools.sh

FROM registry.access.redhat.com/ubi10/ubi-minimal@sha256:04febb4a74cc9ef3eca05ef851d92957276cc6e82fe8cb1ee44abf5114d440d8

LABEL org.opencontainers.image.source="https://github.com/InHolland-Cloud-Minor-2627/img-okd-tools" \
      org.opencontainers.image.description="Runs a OKD client in a container"

RUN microdnf install -y procps-ng jq && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/
COPY kubeconform /usr/local/share/kubeconform/
