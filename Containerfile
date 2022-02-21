FROM registry.fedoraproject.org/fedora:35

RUN dnf install -y rpm-ostree selinux-policy selinux-policy-targeted policycoreutils \
  && mkdir -p /mnt/worktree/upstream

WORKDIR /mnt/worktree

COPY compose.sh ewk-desktop.yaml ewk-post.sh \
  alebastr-sway-extras-fedora-35.repo \
  deathwish-emacs-pgtk-nativecomp-fedora-35.repo \
  2015-RH-IT-Root-CA.pem \
  /mnt/worktree/

COPY upstream/* /mnt/worktree/upstream/

RUN ln -s upstream/fedora-35.repo fedora-35.repo \
  && ln -s upstream/fedora-35-updates.repo fedora-35-updates.repo

CMD bash /mnt/worktree/compose.sh
