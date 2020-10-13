
#
# Debian packaging
#
name = udpxy
version = 1.0.23-12
release = 2

dist_url = http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz

debbuild_dir = $(CURDIR)/debbuild

all: deb

clean:
	@echo "Cleaning..."
	rm -rf $(debbuild_dir) *.deb $(name)*

pre_debbuild:
	@echo "Prepare for Debian building in $(debbuild_dir)"
	mkdir -p $(debbuild_dir)
	test -f $(debbuild_dir)/$(name)_$(version).orig.tar.gz || wget -O $(debbuild_dir)/$(name)_$(version).orig.tar.gz $(dist_url)
	tar -C $(debbuild_dir) -xzf $(debbuild_dir)/$(name)_$(version).orig.tar.gz
	cp -r debian $(debbuild_dir)/$(name)-$(version)

deb-src: pre_debbuild
	@echo "Building Debian source package in $(debbuild_dir)"
	cd $(debbuild_dir) && dpkg-source -b $(name)-$(version)
	find $(debbuild_dir) -maxdepth 1 -type f -exec cp '{}' . \;

deb: pre_debbuild
	@echo "Building Debian package in $(debbuild_dir)"
	cd $(debbuild_dir)/$(name)-$(version) && debuild -us -uc 
	find $(debbuild_dir) -maxdepth 1 -name "*.deb" -exec cp '{}' . \;
