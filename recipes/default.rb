%w[ automake libtool pkgconfig git gettext-devel file make flex openssl-devel ].each do |pkg|
  package pkg do
    action :install
  end
end

git '/tmp/libconfuse' do
  repository 'https://github.com/martinh/libconfuse'
  action :sync
end

git '/tmp/inadyn' do
  repository 'https://github.com/troglobit/inadyn'
  revision 'master'
  enable_submodules true
  action :sync
end

execute "Compile and install libconfuse" do
  command "./autogen.sh; ./configure && make && make install"
  cwd "/tmp/libconfuse"
end

execute "Compile and install inadyn" do
  command "(cd libite; ./autogen.sh; ./configure);./autogen.sh; ./configure --enable-openssl && make && make install"
  cwd "/tmp/inadyn"
end

data_bag = Chef::EncryptedDataBagItem.load("configuration", "inadyn")

template "/etc/inadyn.conf" do
  variables data_bag["inadyn"]
  mode 0600
end
