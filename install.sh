#!/bin/sh
ulimit -c unlimited
#ulimit -u unlimited

base_dir="$(cd "$(dirname "$0")";pwd)"

$(unalias cp)

$(cd "${base_dir}")

echo "copy file usr/local/bin/*"
$(cp -rf usr/local/bin/* /usr/local/bin/)
$(cp -rf usr/local/bin/* /usr/bin/)
echo "copy file usr/local/include/*"
$(cp -rf usr/local/include/* /usr/local/include/)
$(cp -rf usr/local/include/* /usr/include/)
echo "copy file usr/local/lib/*"
$(cp -rf usr/local/lib/* /usr/local/lib/)
$(cp -rf usr/local/lib/* /usr/lib/)
echo "copy file usr/local/lib64/*"
$(cp -rf usr/local/lib64/* /usr/local/lib64/)
$(cp -rf usr/local/lib64/* /usr/lib64/)
echo "copy file usr/local/libexec/*"
$(cp -rf usr/local/libexec/* /usr/local/libexec/)
$(cp -rf usr/local/libexec/* /usr/libexec/)
echo "copy file usr/local/share/*"
$(cp -rf usr/local/share/* /usr/local/share/)
$(cp -rf usr/local/share/* /usr/share/)


if [ $? -eq 0 ]; then
echo "copy file success, then change link"
$(cp /usr/local/lib64/libstdc++.so.6.0.20 /usr/lib64/)
$(ln -sf /usr/lib64/libstdc++.so.6.0.20 /usr/lib64/libstdc++.so.6)
else
echo "copy file error"
exit 1
fi

if [ $? -eq 0 ]; then
echo "change link success, then change PATH"
$(updatedb)
$(update-alternatives --install /usr/bin/gcc gcc /usr/local/bin/x86_64-unknown-linux-gnu-gcc 40 )
# $(echo 'export PATH=/usr/local/bin:$PATH' >> '/etc/bashrc')
else
echo "change link error"
exit 1
fi

echo "install gdb success"

echo ""
echo "==============================="
echo ""
echo "plase enter command under your own account:"
echo "echo 'export PATH=/usr/local/bin:\$PATH' >> ~/.bashrc ; source ~/.bashrc"
echo ""
echo "==============================="
echo ""
