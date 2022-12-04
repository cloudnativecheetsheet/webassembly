# builder stage
FROM rust:1.65.0 AS builder

RUN rustup target add wasm32-wasi

WORKDIR /build
COPY Cargo.toml .
COPY src /build/src/

RUN cargo build --target wasm32-wasi --release

# container image
FROM scratch

COPY --from=builder /build/target/wasm32-wasi/release/hello.wasm /hello.wasm

ENTRYPOINT ["/hello.wasm"]

