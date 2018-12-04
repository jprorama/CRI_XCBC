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

#Building the Native SP from SRPM Source Packages
It results in a set of packages you can install or upgrade easily across many machines.

```
yum install automake boost-devel chrpath doxygen gcc-c++ groff httpd-devel libidn-devel openldap-devel openssl-devel 
redhat-rpm-config rpm-build stunnel unixODBC-devel
```



