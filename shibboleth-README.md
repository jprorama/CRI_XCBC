Open OnDemand uses Apache HTTP Server 2.4 provided by Software Collections. This means that any Apache 
authentication module (mod_auth_*) used will need to be compiled against the apxs and apr tools that reside under:

``` 
/opt/rh/httpd24/root/usr/bin 

```

Install Apache HTTP Server 2.4 as Software collections package.

```
Install a package with repository for your system:
On CentOS, install package centos-release-scl available in CentOS repository:

$ sudo yum install centos-release-scl


Install the collection:

$ sudo yum install httpd24


Start using the software collection:

$ scl enable httpd24 bash 


Check which software collections are enabled

$ echo $X_SCL


If you would like to view additional subpackages installed run

$ sudo yum list httpd24\*


If you don't see httpd24-httpd-devel.x86_64 in the list of installed packages run

$ sudo yum install httpd24-httpd-devel.x86_64

This installs apxs into /opt/rh/httpd24/root/usr/bin 

```

# Building the Native SP from SRPM Source Packages
> It results in a set of packages you can install or upgrade easily across many machines.

### Install the following prerequisites first.
```
yum install automake boost-devel chrpath doxygen gcc-c++ groff httpd-devel libidn-devel openldap-devel openssl-devel 
redhat-rpm-config rpm-build stunnel unixODBC-devel
```

### Make a new directory to download and save the SRPMS.
```
$ mkdir /usr/src/redhat/SRPMS/
$ cd /usr/src/redhat/SRPMS/
```

### Download the SRPMs from [here](https://shibboleth.net/downloads/service-provider/latest/SRPMS/)  and save to /usr/src/redhat/SRPMS/
```
RPMS_ORDER='log4shib-2.0.0-3.1.src.rpm xerces-c-3.2.1-1.1.src.rpm xml-security-c-2.0.2-3.1.src.rpm curl-openssl-7.61.0-1.1.src.rpm xmltooling-3.0.2-3.1.src.rpm opensaml-3.0.0-1.1.src.rpm shibboleth-3.0.2-1.1.src.rpm'
for rpm in $RPMS_ORDER; do echo $rpm;
    wget "https://download.opensuse.org/repositories/security:/shibboleth/CentOS_7/src/$rpm"
done
```

### Build the RPMs from SRPMS
> The shib source rpm has special instructions, so do that seperately

```
for rpm in $RPMS_ORDER; do echo $rpm;
  if [[ $rpm != shibboleth* ]]; then
    sudo rpmbuild --rebuild $rpm
    sudo yum localinstall -y /usr/src/rpm/RPMS/x86_64/*.rpm
  fi
done
```

```
export PKG_CONFIG_PATH=/opt/shibboleth/lib64/pkgconfig/
```

> Shibboleth needs to be built differently since it assumes differently-named apache24 packages. We need to tell the build to ignore looking for OS packages. 
Remember to use -E with sudo so that your export is preserved

```
sudo -E rpmbuild --rebuild --without builtinapache -D 'shib_options -with-apxs24=/opt/rh/httpd24/root/usr/bin/apxs -enable-apache-24' shibboleth*
```
> NOTE: Notice the -with-apxs24 option where we build shibboleth against /opt/rh/httpd24/root/usr/bin/apxs but not the system default. Also note that we removed the -with-apr1 option since we don't really need the portability for our purpose. 

### Install Shibboleth
> If you got the RPM directly from [here](https://github.com/eesaanatluri/CRI_XCBC/blob/feat-shibboleth/shibboleth-3.0.2-1.1.x86_64.rpm) you just need to run this after following the initial steps of Apache2.4 install as software collections pkg.

```
sudo yum localinstall /usr/src/rpm/RPMS/x86_64/shibboleth-3.0.2-1.1.x86_64.rpm
```

### Confirm it has the apache mod you need
```
rpm -qpl /usr/src/rpm/RPMS/x86_64/shibboleth-3.0.2-1.1.x86_64.rpm | grep mod_shib
```
Expected output: /usr/lib64/shibboleth/mod_shib_24.so

### Add a configuration directive to load the module.
> You will need to add a configuration directive to actually load the module, since those are also stored in an atypical directory, /etc/httpd/conf.modules.d/. The typical shib.conf file for Apache 2.4 will work.
```
ln -s /etc/shibboleth/apache24.config /etc/httpd/conf.modules.d/shib.conf
```

# Test the Shib installation.
