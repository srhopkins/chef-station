FROM jrwesolo/centos-with-chef:6

RUN yum install -y \
  wget \
  git \
  tar \
  tree \
  vim

RUN wget -q https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.5.1-1.el6.x86_64.rpm && \
  rpm -Uvh chefdk-0.5.1-1.el6.x86_64.rpm && \
  rm chefdk-0.5.1-1.el6.x86_64.rpm

#RUN chef verify

RUN echo 'eval "$(chef shell-init bash)"' >> ~/.bashrc

WORKDIR /root

RUN chef generate repo chef-repo

RUN mkdir -p ~/chef-repo/.chef

RUN echo '.chef' >> ~/chef-repo/.gitignore

COPY conf/knife.rb /root/chef-repo/.chef/

WORKDIR /root/chef-repo

RUN echo -e 'echo Getting keys ...\ncurl -k https://chef-server:4443/knife_admin_key.tar.gz | tar xz -C /root/chef-repo/.chef/' >> ~/.bashrc

RUN echo -e 'echo Running: knife ssl fetch\nknife ssl fetch && knife ssl check' >> ~/.bashrc

RUN echo -e 'echo Initial kitchen config\nkitchen init --driver=docker' >> ~/.bashrc
