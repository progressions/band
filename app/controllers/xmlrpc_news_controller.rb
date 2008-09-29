class XmlrpcNewsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :load_sidebar
  
  web_service_scaffold :invoke
  wsdl_service_name 'Xmlrpc_News'
  
  web_service_dispatching_mode :layered
  web_service(:metaWeblog) { MetaWeblogNewsService.new() }
  web_service(:blogger) { BloggerNewsService.new() }
end