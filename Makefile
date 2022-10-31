
#
# Debian packaging
#
name = udpxy
upstream_version = 1.0-25.1

version = 1.0.25-1
release = 0

dist_url = https://github.com/pcherenkov/udpxy/archive/refs/tags/$(upstream_version).tar.gz

debbuild_dir = $(CURDIR)/debbuild
tmp_dir = $(CURDIR)/tmp

all: deb

clean:
	@echo "Cleaning..."
	rm -rf $(debbuild_dir) $(tmp_dir) *.deb $(name)*

upstream_dist:
	@echo "Download upstream tar.gz and repackage"
	mkdir -p $(tmp_dir)
	test -f $(tmp_dir)/$(upstream_version).tar.gz || wget -O $(tmp_dir)/$(upstream_version).tar.gz $(dist_url)
	cd $(tmp_dir) && tar -xzf $(upstream_version).tar.gz
	cd $(tmp_dir)/$(name)-$(upstream_version)/chipmunk && make dist
	mv $(tmp_dir)/$(name)-$(upstream_version)/$(name).$(version)-prod.tar.gz $(tmp_dir)/$(name)-$(version).tar.gz


pre_deb: upstream_dist
	@echo "Prepare for Debian building in $(debbuild_dir)"
	mkdir -p $(debbuild_dir)
	test -f $(debbuild_dir)/$(name)_$(version).orig.tar.gz || cp $(tmp_dir)/$(name)-$(version).tar.gz $(debbuild_dir)/$(name)_$(version).orig.tar.gz
	tar -C $(debbuild_dir) -xzf $(debbuild_dir)/$(name)_$(version).orig.tar.gz
	cp -r debian $(debbuild_dir)/$(name)-$(version)

deb-src: pre_deb
	@echo "Building Debian source package in $(debbuild_dir)"
	cd $(debbuild_dir) && dpkg-source -b $(name)-$(version)
	find $(debbuild_dir) -maxdepth 1 -type f -exec cp '{}' . \;

deb: pre_deb
	@echo "Building Debian package in $(debbuild_dir)"
	cd $(debbuild_dir)/$(name)-$(version) && debuild -us -uc 
	find $(debbuild_dir) -maxdepth 1 -name "*.deb" -exec cp '{}' . \;
