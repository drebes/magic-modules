# Copyright 2018 Google Inc.
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

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# Add our google/ lib
$LOAD_PATH.unshift ::File.expand_path('../libraries', ::File.dirname(__FILE__))

require 'google/hash_utils'
require 'inspec/resource'


# A provider to manage Google Compute Engine resources.
class Networks < Inspec.resource(1)

  name 'google_compute_networks'
  desc 'Network plural'
  supports platform: 'gcp2'

  filter_table_config = FilterTable.create
  filter_table_config.add(:descriptions, field: :description)
  filter_table_config.add(:gateway_ipv4s, field: :gateway_ipv4)
  filter_table_config.add(:ids, field: :id)
  filter_table_config.add(:ipv4_ranges, field: :ipv4_range)
  filter_table_config.add(:names, field: :name)
  filter_table_config.add(:subnetworks, field: :subnetworks)
  filter_table_config.add(:auto_create_subnetworks, field: :auto_create_subnetworks)
  filter_table_config.add(:creation_timestamps, field: :creation_timestamp)
  filter_table_config.connect(self, :fetch_data)


def base
  'https://www.googleapis.com/compute/v1/'
end

def url
  'projects/{{project}}/global/networks'
end

  def initialize(params = {}) 
    @params = params
  end  

  def exists?
    !@data.nil?
  end

  def fetch_resource(params, kind)
    get_request = inspec.backend.fetch(base, url, params)
    return_if_object get_request.send, kind
  end

  def fetch_data
    @data = fetch_wrapped_resource('compute#network', 'compute#autoscalerList', 'items')
  end

  def fetch_wrapped_resource(kind, wrap_kind, wrap_path)
    result = fetch_resource(@params, wrap_kind)
    return if result.nil? || !result.key?(wrap_path)

    # TODO hacky conversion of string => string hash to symbol => string hash
    res = result[wrap_path]
    real = []
    res.each do |x|
      n = {}
      x.each_pair { |k, v| n[k.to_sym] = v }
      real.push(n)
    end

    real
  end

  def self.raise_if_errors(response, err_path, msg_field)
    errors = Google::HashUtils.navigate(response, err_path)
    raise_error(errors, msg_field) unless errors.nil?
  end

  def self.raise_error(errors, msg_field)
    raise IOError, ['Operation failed:',
                    errors.map { |e| e[msg_field] }.join(', ')].join(' ')
  end


  # rubocop:disable Metrics/CyclomaticComplexity
  def self.return_if_object(response, kind, allow_not_found = false)
    raise "Bad response: #{response.body}" \
      if response.is_a?(Net::HTTPBadRequest)
    raise "Bad response: #{response}" \
      unless response.is_a?(Net::HTTPResponse)
    return if response.is_a?(Net::HTTPNotFound) && allow_not_found 
    return if response.is_a?(Net::HTTPNoContent)
    result = JSON.parse(response.body)
    raise_if_errors result, %w[error errors], 'message'
    raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def return_if_object(response, kind, allow_not_found = false)
    self.class.return_if_object(response, kind, allow_not_found)
  end



end
