FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/ngerakines/commitment.git && \
    cd commitment && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM python:alpine

WORKDIR /commitment
COPY --from=base /git/commitment .
RUN pip install --no-cache-dir -r requirements.txt
CMD [ "python3", "commit.py" ]
EXPOSE 5000
