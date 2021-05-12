FROM centos:8
ENV container docker
RUN curl -Lo /tini https://github.com/krallin/tini/releases/download/v0.18.0/tini-amd64; \
chmod 755 /tini
RUN yum install -y epel-release cpanminus gcc rsyslog openssl-devel 'dnf-command(config-manager)'; \
yum config-manager --set-enabled powertools; \
yum -y update; \
yum install -y 'perl(File::ShareDir::Install)' 'perl(Net::Server)' 'perl(Mail::SPF)' 'perl(Crypt::OpenSSL::RSA)' 'perl(Mail::DKIM)' 'perl(Email::Date::Format)' 'perl(Net::IP)' 'perl(Email::Simple)' 'perl(JSON)' 'perl(Proc::ProcessTable)' 'perl(ExtUtils::InstallPaths)' 'perl(ExtUtils::Helpers)' 'perl(Module::Build::Tiny)' 'perl(Module::Runtime)' 'perl(DBD::SQLite)' 'perl(Regexp::Common)' 'perl(Email::MessageID)' 'perl(Email::MIME::ContentType)' 'perl(Email::Address::XS)' 'perl(DBI)' 'perl(File::ShareDir)' 'perl(Config::Tiny)' 'perl(XML::LibXML)' 'perl(Sub::Quote)' 'perl(XString)' 'perl(JSON::MaybeXS)' 'perl(Crypt::OpenSSL::RSA)' 'perl(Net::SSLeay)' 'perl(Import::Into)' 'perl(Clone)' 'perl(Email::Sender::Simple)' 'perl(Text::Table)' 'perl(JSON::XS)' 'perl(Date::Manip::Date)' 'perl(Test::File::Contents)' 'perl(File::Slurp)' 'perl(Sereal)' 'perl(List::MoreUtils)' 'perl(SUPER)' 'perl(Class::Tiny)' 'perl(File::Copy::Recursive)' 'perl(Scope::Guard)' 'perl(Path::Tiny)' 'perl(Log::Dispatch::File)' 'perl(Log::Dispatch)' 'perl(Log::Dispatch::Array)' 'perl(Log::Dispatch::Syslog)' 'perl(Log::Dispatch::Screen)' 'perl(Moose::Role)' 'perl(Crypt::OpenSSL::X509)' 'perl(Moose::Util::TypeConstraints)' 'perl(Moose)' 'perl(Convert::ASN1)' 'perl(Cache::FastMmap)' 'perl(Class::Accessor::Lite)' 'perl(Capture::Tiny)' 'perl(File::chdir)' 'perl(Getopt::Long::Descriptive)' 'perl(Scalar::String)' 'perl(Test::Exception)'; \
yum clean all; \
cd /root; \
curl -L -o Mail-Milter-Authentication-3.20210512.tar.gz https://github.com/fastmail/authentication_milter/files/6464005/Mail-Milter-Authentication-3.20210512.tar.gz; \
cpanm -n Mail-Milter-Authentication-3.20210512.tar.gz; \
rm -rf Mail-Milter-Authentication-3.20210512.tar.gz /root/.cpanm
COPY . /
ENTRYPOINT ["/tini", "/start_authentication_milter.sh"]
