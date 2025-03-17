FROM python:3.13-slim AS base

FROM base AS builder

RUN apt update && apt install -y python3-dev && mkdir /install
WORKDIR /install
COPY requirements.txt ./
RUN pip install --no-cache-dir --prefix=/install -r ./requirements.txt


FROM base AS final

COPY --from=builder /install /usr/local

ARG APP_DIR=/usr/src/app
ARG GIT_SHA
ARG GIT_TAG

LABEL org.opencontainers.image.vendor="amerkurev"

ENV IN_DOCKER=1 \
	GIT_SHA=$GIT_SHA \
	GIT_TAG=$GIT_TAG


COPY src $APP_DIR

WORKDIR $APP_DIR

CMD ["python"]
