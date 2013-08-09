#
# Cookbook Name:: nginx
# Attributes:: source
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012, Riot Games
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

include_attribute 'nginx'

default['nginx']['source']['version']                 = node['nginx']['version']

default['nginx']['configure_flags']  = Array.new
default['nginx']['source']['version']  = node['nginx']['version']
default['nginx']['source']['checksum'] = "0510af71adac4b90484ac8caf3b8bd519a0f7126250c2799554d7a751a2db388"
default['nginx']['source']['modules'] = [
  "http_ssl_module",
  "http_gzip_static_module"
]
default['nginx']['source']['extra_modules'] = []
