#
# Cookbook Name:: nginx
# Recipe:: Passenger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

packages = value_for_platform( ["redhat", "centos", "scientific", "amazon", "oracle"] => {
                                 "default" => %w(ruby-devel curl-devel) },
                               ["ubuntu", "debian"] => {
                                 "default" => %w(ruby-dev libcurl4-gnutls-dev) } )

packages.each do |devpkg|
  package devpkg
end

gem_package 'rake'

gem_package 'passenger' do
  action :install
  version node["nginx"]["passenger"]["version"]
  gem_binary node["nginx"]["passenger"]["gem_binary"] if node["nginx"]["passenger"]["gem_binary"]
end

passenger_variables = node["nginx"]["passenger"].reject { |k,v| %w(version gem_binary).include? k }

template "#{node["nginx"]["dir"]}/conf.d/passenger.conf" do
  source "modules/passenger.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables(passenger_variables: passenger_variables)
  notifies :reload, "service[nginx]"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{node["nginx"]["passenger"]["root"]}/ext/nginx"]
