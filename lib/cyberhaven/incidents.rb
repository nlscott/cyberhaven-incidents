# frozen_string_literal: true

require "uri"
require "json"
require 'yaml'
require "net/http"
require 'openssl'
require 'base64'
require_relative "incidents/version"
require_relative "incidents/id"

module Cyberhaven
  module Incidents

    def self.getBearerToken
      decode = Base64.decode64("#{$refreshToken}")
      $query = decode
  
      url = URI("https://#{$deployment}/user-management/auth/token")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request.body = $query
      response = https.request(request)
      $bearerToken =  response.read_body.strip
    end

    def self.totalIncidents
      url = URI("https://#{$deployment}/api/rest/v1/incidents/list")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{$bearerToken}"
      request.body = JSON.dump({})
      response = https.request(request)
      status = response.code
      results = JSON.parse(response.read_body)
      puts results["total"].to_i
    end

    def self.totalUnresolvedIncidents
      $query ={
        "filters":{
          "resolution_statuses":[
              "unresolved"
          ],
        },
          "page_size": 1,
      }.to_json
  
      url = URI("https://#{$deployment}/api/rest/v1/incidents/list")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{$bearerToken}"
      request.body = $query
      response = https.request(request)
      status = response.code
      results = JSON.parse(response.read_body)
      puts results["total"].to_i
    end

    def self.totalIgnoredIncidents
      $query ={
        "filters":{
            "resolution_statuses":[
                "ignored"
            ]
        },
        "sort_by": "event_time",
        "page_size": 1,
        "sort_desc": true
      }.to_json
  
      url = URI("https://#{$deployment}/api/rest/v1/incidents/list")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{$bearerToken}"
      request.body = $query
      response = https.request(request)
      status = response.code
      results = JSON.parse(response.read_body)
      puts results["total"].to_i
    end

    def self.totalInProgressIncidents
      $query ={
        "filters":{
          "resolution_statuses":[
              "in_progress"
          ],
        },
          "page_size": 100,
      }.to_json
  
      url = URI("https://#{$deployment}/api/rest/v1/incidents/list")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{$bearerToken}"
      request.body = $query
      response = https.request(request)
      status = response.code
      results = JSON.parse(response.read_body)  
      puts results["total"].to_i
    end

    def self.totalResolvedIncidents
      $query ={
        "filters":{
          "resolution_statuses":[
              "resolved"
          ],
        },
          "page_size": 100,
      }.to_json
  
      url = URI("https://#{$deployment}/api/rest/v1/incidents/list")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{$bearerToken}"
      request.body = $query
      response = https.request(request)
      status = response.code
      results = JSON.parse(response.read_body)
      puts results["total"].to_i
    end

  end
end