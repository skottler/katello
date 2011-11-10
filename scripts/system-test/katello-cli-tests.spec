# vim: sw=4:ts=4:et
#
# Copyright 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

%define base_name katello
%global homedir %{_datarootdir}/%{base_name}

Name:          %{base_name}-cli-tests
Summary:       System tests for Katello client package
Group:         Applications/System
License:       GPLv2
URL:           http://www.katello.org
Version:       0.1.3
Release:       1%{?dist}
Source0:       %{name}-%{version}.tar.gz
BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:      %{base_name}-cli
BuildArch:     noarch


%description
Provides a test scripts for client package for managing 
application life-cycle for Linux systems


%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT
install -d -m 755 $RPM_BUILD_ROOT%{homedir}/script/cli-tests
pwd
ls
cp -Rp cli_tests/ cli-system-test helpers *zip $RPM_BUILD_ROOT%{homedir}/script/cli-tests


%clean
rm -rf $RPM_BUILD_ROOT

%files 
%{homedir}/script/cli-tests


%changelog
* Thu Nov 10 2011 Lukas Zapletal <lzap+git@redhat.com> 0.1.3-1
- possibility to run system tests from rpm
- getting katello-cli-tests.spec working

* Thu Nov 10 2011 Lukas Zapletal <lzap+git@redhat.com> 0.1.2-1
- new package built with tito

* Thu Sep 08 2011 Lukas Zapletal <lzap+git@redhat.com> 0.1.1-1
- initial version