# `mkdocs-material` Docker container image

```bash
docker pull ghcr.io/patrickdappollonio/mkdocs-material-pipenv-v9:latest
```

This is a very biased `mkdocs-material` container image that is intended to be used as a base for a `mkdocs-material` project. It includes a handful of plugins curated by the author.

It also includes `pipenv` in case your project might use it to define version constraints.

The plugins installed and their dependencies are (see [`requirements.txt`](requirements.txt) for more information):

```bash
mkdocs-material==9.*
mkdocs-awesome-pages-plugin==2.9.*
mkdocs-git-revision-date-localized-plugin==1.2.*
mdx_truly_sane_lists==1.3
mkdocs-glightbox==0.3.4
mkdocs-htmlproofer-plugin==1.0.0
```

The terminal has been replaced to `bash` (in replacement of `ash`, original in Alpine), and `sudo` has been installed in case the user needs to escalate to install OS level packages. `sudo` has no password requirement, and as such, **it is not recommended to use this container as a shell for a live production environment**. You can alternatively disable the `sudo` passwordless use by expanding from this image and running:

```bash
sudo echo "" > /etc/sudoers
```

### FAQ

#### Can I add my own plugins?

Send me a Pull Request and I'll see what we can do!

#### No versions?

Since this image is built from the main branch commit and the versions are pinned, if you are looking at a specific version, I would recommend pinning using SHAs. Old versions of the image via SHA are kept and never deleted.

Additionally, this image rebuilds itself every week.
