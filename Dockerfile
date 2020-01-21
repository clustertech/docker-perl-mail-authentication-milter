FROM centos:8
ENV container docker
RUN curl -Lo /tini https://github.com/krallin/tini/releases/download/v0.18.0/tini-amd64; \
chmod 755 /tini
RUN yum install -y epel-release cpanminus gcc rsyslog; \
yum install -y update; \
yum install -y 'perl(File::ShareDir::Install)' 'perl(Net::Server)' 'perl(Mail::SPF)' 'perl(Crypt::OpenSSL::RSA)' 'perl(Mail::DKIM)' 'perl(Email::Date::Format)' 'perl(Net::IP)' 'perl(Email::Simple)' 'perl(JSON)' 'perl(Proc::ProcessTable)' 'perl(ExtUtils::InstallPaths)' 'perl(ExtUtils::Helpers)' 'perl(Module::Build::Tiny)' 'perl(Module::Runtime)' 'perl(DBD::SQLite)' 'perl(Regexp::Common)' 'perl(Email::MessageID)' 'perl(Email::MIME::ContentType)' 'perl(Email::Address::XS)' 'perl(DBI)' 'perl(File::ShareDir)' 'perl(Config::Tiny)' 'perl(XML::LibXML)' 'perl(Sub::Quote)' 'perl(XString)' 'perl(JSON::MaybeXS)'; \
yum clean all; \
cpanm -n Mail::Milter::Authentication
COPY . /
ENTRYPOINT ["/tini", "/start_authentication_milter.sh"]
