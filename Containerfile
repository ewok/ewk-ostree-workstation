FROM registry.fedoraproject.org/fedora:35

RUN dnf install -y rpm-ostree selinux-policy selinux-policy-targeted policycoreutils \
  && mkdir -p /mnt/worktree

WORKDIR /mnt/worktree

COPY upstream compose.sh ewk-desktop.yaml ewk-post.sh \
  alebastr-sway-extras-fedora-34.repo \
  2015-RH-IT-Root-CA.pem \
  /mnt/worktree/

CMD bash /mnt/worktree/compose.sh
