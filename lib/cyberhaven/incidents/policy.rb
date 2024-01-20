# frozen_string_literal: true


require 'etc'
require 'csv'


module Cyberhaven
  module Incidents
    module Policy
        def self.TotalPolicyIncidents(policyName)
            
            $pageToken = "1"
            loop do
                unless $pageToken.empty?
        
                    if $pageToken == "1"
                        $pageToken = ""
                    end

                    $query ={
                        "filters":{
                            "category_names": [
                                "#{policyName}"
                            ],
                        },
                        "sort_by": "event_time",
                        "page_id": "#{$pageToken}",
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

                    puts results["total"]
                else
                    break
                end
            end
        end
        
        def self.AllIncidentsResults(policyName)

            $incidentArray = []
            
            $pageToken = "1"
            loop do
                unless $pageToken.empty?
        
                    if $pageToken == "1"
                        $pageToken = ""
                    end

                    $query ={
                        "filters":{
                            "resolution_statuses":[
                                "unresolved", "ignored", "in_progress", "resolved"
                            ],
                            "category_names": [
                                "#{policyName}"
                            ],
                        },
                        "sort_by": "event_time",
                        "page_id": "#{$pageToken}",
                        "page_size": 1000,
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

                    $pageToken = results["next_page_id"]
                    results["incidents"].each do |item|
                        $incidentArray.push(item)
                    end
                else
                    break
                end
            end
        end

        def self.AllIncidents(policyName)
            AllIncidentsResults("#{policyName}")
            return $incidentArray
        end

        def self.AllIncidentsCSV(policyName)
            now_date = DateTime.now
            datetime = now_date.strftime('%Y%m%d')
            $currentUser = ENV['USER']
            $reportPath="/Users/#{$currentUser}/Desktop/#{datetime}_#{policyName}_report.csv"
    
            $pageToken = "1"
            $incidentArray = []
          
            loop do
                unless $pageToken.empty?
        
                    if $pageToken == "1"
                        $pageToken = ""
                    end
        
                    $query ={
                        "filters":{
                            "resolution_statuses":[
                                "unresolved", "ignored", "in_progress", "resolved"
                            ],
                            "category_names": [
                                "#{policyName}"
                            ],
                        },
                        "page_id": "#{$pageToken}",
                        "sort_by": "event_time",
                        "page_size": 1000,
                        "sort_desc": true
                    }.to_json
        
                    url = URI("https://dailypay.cyberhaven.io/api/rest/v1/incidents/list")
                    https = Net::HTTP.new(url.host, url.port)
                    https.use_ssl = true
                    request = Net::HTTP::Get.new(url)
                    request["Content-Type"] = "application/json"
                    request["Authorization"] = "Bearer #{$bearerToken}"
                    request.body = $query
                    response = https.request(request)
                    status = response.code
                    results = JSON.parse(response.read_body)
                    
                    $pageToken = results["next_page_id"]
                    # puts results["total"]
                    # puts results["next_page_id"]
        
                    array = []
                    results["incidents"].each do |item|
                    $incident_hash = {
                        "Event Time" => "#{item["event_time"]}",
                        "Trigger Time" => "#{item["trigger_time"]}",
                        "ID" => "#{item["id"]}",
                        "Incident Risk Score" => "#{item["risk_score"]}",
                        "Policy Name" => "#{item["category"]["name"]}",
                        "Policy Severity" => "#{item["category"]["severity"]}",
                        "User" => "#{item["user"]}",
                        "Assignee" => "#{item["assignee"]}",
                        "Status" => "#{item["resolution_status"]}",
                        "Severity" => "#{item["severity"]}",
                        "Dataset Name" => "#{item["dataset"]["name"]}",
                        "Category Severity" => "#{item["category"]["severity"]}",
                        "File" => "#{item["file"]}",
                        "Data Path" => "#{item["data"]["path"]}",
                        "Source Path" => "#{item["source_data"]["path"]}",
                        "Content Tags" => "#{item["content_tags"]}",
                        "Source Path " => "#{item["edge"]["source"]["path"]}",
                        "Source Extension" => "#{item["edge"]["source"]["extension"]}",
                        "Source Url" => "#{item["edge"]["source"]["url"]}",
                        "Source Browser Url" => "#{item["edge"]["source"]["browser_page_url"]}",
                        "Source Domain" => "#{item["edge"]["source"]["browser_page_domain"]}",
                        "Source Browser Title" => "#{item["edge"]["source"]["browser_page_title"]}",
                        "Source Hostname" => "#{item["edge"]["source"]["hostname"]}",
                        "Source URI" => "#{item["edge"]["source"]["content_uri"]}",
                        "Source Location" => "#{item["edge"]["source"]["location"]}",
                        "Source Location Outline" => "#{item["edge"]["source"]["location_outline"]}",
                        "Source Category" => "#{item["edge"]["source"]["category"]}",
                        "Source Links" => "#{item["edge"]["source"]["links"]}",
                        "Source ID" => "#{item["edge"]["source"]["links"]}",
                        "Tags Applied" => "#{item["edge"]["source"]["tags_applied"]}",
                        "Source Upload URI" => "#{item["edge"]["source"]["content_upload_uri"]}",
                        "Source Report URI" => "#{item["edge"]["source"]["content_report_uri"]}",
                        "Source Event Type" => "#{item["edge"]["source"]["event_type"]}",
                        "Source Sensor Name" => "#{item["edge"]["source"]["sensor_name"]}",
                        "Source Local User" => "#{item["edge"]["source"]["local_user_name"]}",
                        "Source Local User ID" => "#{item["edge"]["source"]["local_user_sid"]}",
                        "Source Local Time" => "#{item["edge"]["source"]["local_time"]}",
                        "Source Local Machine" => "#{item["edge"]["source"]["local_machine_name"]}",
                        "Source Endpoint ID" => "#{item["edge"]["source"]["endpoint_id"]}",
                        "Source Local ID" => "#{item["edge"]["source"]["local_id"]}",
                        "Destination Path" => "#{item["edge"]["destination"]["path"]}",
                        "Destination Extension" => "#{item["edge"]["destination"]["extension"]}",
                        "Destination Upload File ID" => "#{item["edge"]["destination"]["upload_file_id"]}",
                        "Destination Browser Page Title" => "#{item["edge"]["destination"]["browser_page_title"]}",
                        "Destination Hostname" => "#{item["edge"]["destination"]["hostname"]}",
                        "Destination MD5" => "#{item["edge"]["destination"]["md5_hash"]}",
                        "Destination File Size" => "#{item["edge"]["destination"]["file_size"]}",
                        "Destination Path Components" => "#{item["edge"]["destination"]["path_components"]}",
                        "Destination Path Basename" => "#{item["edge"]["destination"]["path_basename"]}",
                        "Destination Domain" => "#{item["edge"]["destination"]["domain"]}",
                        "Destination URI" => "#{item["edge"]["destination"]["content_uri"]}",
                        "Destination Location" => "#{item["edge"]["destination"]["location"]}",
                        "Destination Location Outline" => "#{item["edge"]["destination"]["location_outline"]}",
                        "Destination Category" => "#{item["edge"]["destination"]["category"]}",
                        "Destination Links" => "#{item["edge"]["destination"]["links"]}",
                        "Destination Event Type" => "#{item["edge"]["destination"]["event_type"]}",
                        "Destination Sensor Name" => "#{item["edge"]["destination"]["sensor_name"]}",
                        "Destination Local User" => "#{item["edge"]["destination"]["local_user_name"]}",
                        "Destination Local User ID" => "#{item["edge"]["destination"]["local_user_sid"]}",
                        "Destination Local Time" => "#{item["edge"]["destination"]["local_time"]}",
                        "Destination Local Machine" => "#{item["edge"]["destination"]["local_machine_name"]}",
                        "Destination Endpoint ID" => "#{item["edge"]["destination"]["endpoint_id"]}",
                        "Destination Local ID" => "#{item["edge"]["destination"]["local_id"]}",
                        "Destination Blocked" => "#{item["edge"]["destination"]["blocked"]}",
                        "Destination Data Size" => "#{item["edge"]["destination"]["data_size"]}",
                        "Destination Google Drive ID" => "#{item["edge"]["destination"]["gdrive_file_id"]}",
                        "Destination Cloud Provider" => "#{item["edge"]["destination"]["cloud_provider"]}",
                        "Destination Cloud App" => "#{item["edge"]["destination"]["cloud_app"]}",
                        "Destination Cloud Account" => "#{item["edge"]["destination"]["cloud_app_account"]}",
                        "Destination Scan ID" => "#{item["edge"]["destination"]["dlp_scan_linking_id"]}"
                    }
                    $incidentArray.push($incident_hash)
                    end
                else
                    break
                end
            end
        
            CSV.open("#{$reportPath}", 'w') do |csv|
                # Write the header based on the keys of the first hash
                csv << $incidentArray.first.keys
              
                # Write each hash as a row in the CSV file
                $incidentArray.each do |hash|
                  csv << hash.values
                end
            end
            puts "Finished writting report: #{$reportPath}"
        end
    
        def self.AllIncidentsJson(policyName)
            AllIncidentsResults("#{policyName}")
            return $incidentArray.to_json
        end

         def self.AllIncidentsYaml(policyName)
            AllIncidentsResults("#{policyName}")
            return $incidentArray.to_yaml
        end

    end
  end
end
