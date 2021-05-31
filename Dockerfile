FROM rust:1.52.1 AS builder

RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /opt

COPY src /opt/src
COPY Cargo.toml /opt/Cargo.toml

RUN cargo install --path . --target x86_64-unknown-linux-musl

FROM alpine:3.13.5

COPY --from=builder /opt/target/x86_64-unknown-linux-musl/release/rust-hello-docker /var/run/rust-hello-docker

RUN /var/run/rust-hello-docker

ENTRYPOINT ["/var/run/rust-hello-docker"]
