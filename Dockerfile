FROM docker:18.06

ENV KUBECTL_VERSION 1.12.0
ENV AWS_IAM_AUTHENTICATOR_VERSION 0.3.0
ENV HELM_VERSION 2.11.0

RUN apk --no-cache update && \
    apk --no-cache add bash python py-pip py-setuptools ca-certificates curl groff less jq && \
    pip --no-cache-dir install awscli yq && \
    rm -rf /var/cache/apk/*

RUN curl -sL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

RUN curl -sL https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${AWS_IAM_AUTHENTICATOR_VERSION}/heptio-authenticator-aws_${AWS_IAM_AUTHENTICATOR_VERSION}_linux_amd64 -o /usr/local/bin/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator

RUN curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
    tar -xvf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin && \
    chmod +x /usr/local/bin/helm && \
    helm init --client-only && \
    rm -rf linux-amd64 && \
    rm helm.tar.gz
