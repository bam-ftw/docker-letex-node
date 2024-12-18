FROM debian:testing

RUN apt-get update && apt-get install -y \
  texlive-full \
  # some auxiliary tools
  wget \
  git \
  openssh-client \
  make \
  xz-utils \
  # markup format conversion tool
  pandoc \
  # XFig utilities
  fig2dev \
  # syntax highlighting package
  python3-pygments \
  # temporary fix for minted, see https://github.com/gpoore/minted/issues/277
  python-is-python3 \
  # Java runtime environment (e.g. for arara)
  default-jre-headless \
  # will be used to add a user
  adduser && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

RUN adduser \
  --home /home/latex \
  --uid 1000 \
  --gecos LaTeX \
  --disabled-password \
  latex

RUN wget https://nodejs.org/dist/v22.12.0/node-v22.12.0-linux-x64.tar.xz

RUN tar -xf node-v22.12.0-linux-x64.tar.xz

RUN mv -f node-v22.12.0-linux-x64/bin/* /usr/bin/
RUN mv -f node-v22.12.0-linux-x64/include/* /usr/include/
RUN mv -f node-v22.12.0-linux-x64/lib/* /usr/lib/
