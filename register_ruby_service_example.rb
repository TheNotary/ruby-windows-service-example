require 'rubygems'
require 'win32/service'

include Win32

SERVICE_NAME = 'ruby_example_service'
SERVICE_DESC = 'And example for using ruby in a windows service'

ruby = 'c:\Ruby192\bin\ruby.exe'
target_folder = 'c:\temp'
target_path = 'ruby_example_service.rb'

# Example:  'c:\Ruby\bin\ruby.exe -C c:\temp ruby_example_service.rb'
binary_path = ruby + ' -C ' + target_folder + ' ' + target_path

install = ARGV.empty?   # if you send an argument, no matter what it will trigger delete routine

if install
  # Create a new service
  Service.create({
    :service_name => SERVICE_NAME,
    :service_type => Service::WIN32_OWN_PROCESS,
    :description => SERVICE_DESC,
    :start_type => Service::AUTO_START,
    :error_control => Service::ERROR_NORMAL,
    :binary_path_name => binary_path,
    :load_order_group => 'Network',
    :dependencies => ['W32Time','Schedule'],
    :display_name => SERVICE_NAME
  })
else

  # delete the service
  # NOTE: if the services applet is up during this operation, the service won't be removed from that ui
  # unitil you close and reopen it (it gets marked for deletion)
  Service.delete(SERVICE_NAME)
end