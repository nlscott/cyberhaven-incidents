# frozen_string_literal: true


module Cyberhaven
  module Incidents
    module Id
        ## DETAILED VERBOSE ----------------------------------------------------
        def self.DetailedRaw(incidentID)
            $query ={
                "filters":{
                    "incident_ids": [
                        "#{incidentID}"
                    ],
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

            $data = results["incidents"]
        end

        def self.DetailedJson(incidentID)
            DetailedRaw("#{incidentID}")
            puts $data.to_json
        end

        def self.DetailedYaml(incidentID)
            DetailedRaw("#{incidentID}")
            puts $data.to_yaml
        end

        def self.DetailedReport(incidentID)
            $query ={
                "filters":{
                    "incident_ids": [
                        "#{incidentID}"
                    ],
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
            
            results["incidents"].each do |item|
                puts "INCIDENT ID: #{item["id"]}"
                puts "  EVENT TIME: #{item["event_time"]}"
                puts "  TRIGGER TIME: #{item["trigger_time"]}"
                puts "  POLICY NAME: #{item["category"]["name"]}"
                puts "  POLICY SEVERITY: #{item["category"]["severity"]}"
                puts "  USER: #{item["user"]}"
                puts "  STATUS: #{item["resolution_status"]}"
                puts "  OUTDATED POLICY: #{item["outdated_policy"]}"
                puts "  FILE: #{item["file"]}"
                puts "  FILE PATH: #{item["data"]["path"]}"
                puts "  SOURCE DATA: #{item["source_data"]["path"]}"
                puts "  PERSONAL INFO:"
                if ! item["personal_info"].nil?
                    item["personal_info"].each do |personalItem|
                        puts "    #{personalItem}"
                    end
                end
                puts "  ASSIGNEE: #{item["assignee"]}"
                puts "  CONTENT TAGS: #{item["content_tags"]}"
                puts "  RESPONSE: #{item["incident_response"]}"
                puts "  REACTION: #{item["incident_reactions"]}"
                puts "  ADMIN HISTORY: #{item["admin_history"]}"
                puts "  CATEGOERY MODIFIED: #{item["category_last_modified"]}"
                puts "  DATASET MODIFIED: #{item["dataset_last_modified"]}"
                puts "  ALERT ID: #{item["alert_id"]}"
                puts "  SCREENSHOT GUID: #{item["screenshot_guid"]}"
                puts ""
        
                puts "  DATASET:"
                puts "    ID: #{item["dataset"]["id"]}"
                puts "    NAME: #{item["dataset"]["name"]}"
                puts "    SENSITIVITY: #{item["dataset"]["sensitivity"]}"
                puts "    LAST MODIFIED: #{item["dataset"]["last_modified"]}"
                puts ""

                puts "  POLICY:"
                puts "    ID: #{item["category"]["id"]}"
                puts "    NAME: #{item["category"]["name"]}"
                puts "    SEVERITY: #{item["category"]["severity"]}"
                puts "    DATASET IDS: #{item["category"]["dataset_ids"]}"
                puts "    EXCLUDE ORIGIN: #{item["category"]["exclude_origin"]}"
                puts "    LAST MODIFIED: #{item["category"]["last_modified"]}"
                puts "    SELECTION TYPE: #{item["category"]["selection_type"]}"
                puts "    RULE:"
                puts "      ID: #{item["category"]["rule"]["id"]}"
                puts "      STATUS: #{item["category"]["rule"]["status"]}"
                puts "      CREATE INCIDENT: #{item["category"]["rule"]["create_incident"]}"
                puts "      RECORD SCREENSHOT: #{item["category"]["rule"]["record_screenshots"]}"
                puts "      NOTIFY ENABLED: #{item["category"]["rule"]["notify_enabled"]}"
                puts "      NOTIFY STATUS: #{item["category"]["rule"]["notify_status"]}"
                puts "      NOTIFY EMAIL: #{item["category"]["rule"]["notify_email"]}"
                puts "      SHOW TITLE: #{item["category"]["rule"]["show_title"]}"
                puts "      SHOW LOGO: #{item["category"]["rule"]["show_logo"]}"
                puts "      REQUIRE JUSTIFICATION: #{item["category"]["rule"]["require_justification"]}"
                puts "      REQUIRE ACKNOWLEDGEMENT: #{item["category"]["rule"]["should_ack_warning"]}"
                puts "      ALLOW REVIEW: #{item["category"]["rule"]["allow_request_review"]}"
                puts "      OVERRIDE ENABLED: #{item["category"]["rule"]["override_enabled"]}"
                puts "      BLOCKING ACTION: #{item["category"]["rule"]["blocking_action"]}"
                puts "      INCIDENT ACTION: #{item["category"]["rule"]["incident_action"]}"
                puts "      WARNING MESSAGE:"
                puts "        TITLE: #{item["category"]["rule"]["warning_dialog"]["title"]}"
                puts "        EXPLANATION: #{item["category"]["rule"]["warning_dialog"]["explanation"]}"
                puts "        PLACEHOLDER: #{item["category"]["rule"]["warning_dialog"]["placeholder"]}"
                puts "        CHECK TEXT: #{item["category"]["rule"]["warning_dialog"]["check_text"]}"
                puts "        REVIEW CHECK TEXT: #{item["category"]["rule"]["warning_dialog"]["review_check_text"]}"
                puts "        SUBMIT LABEL: #{item["category"]["rule"]["warning_dialog"]["submit_label"]}"
                puts "        ALLOW LABEL: #{item["category"]["rule"]["warning_dialog"]["allow_label"]}"
                puts "      BLOCKING MESSAGE:"
                puts "        TITLE: #{item["category"]["rule"]["blocking_dialog"]["title"]}"
                puts "        EXPLANATION: #{item["category"]["rule"]["blocking_dialog"]["explanation"]}"
                puts "        PLACEHOLDER: #{item["category"]["rule"]["blocking_dialog"]["placeholder"]}"
                puts "        CHECK TEXT: #{item["category"]["rule"]["blocking_dialog"]["check_text"]}"
                puts "        REVIEW CHECK TEXT: #{item["category"]["rule"]["blocking_dialog"]["review_check_text"]}"
                puts "        SUBMIT LABEL: #{item["category"]["rule"]["blocking_dialog"]["submit_label"]}"
                puts "        ALLOW LABEL: #{item["category"]["rule"]["blocking_dialog"]["allow_label"]}"
                puts ""
                
                puts "  SOURCE INFORMATION:"
                puts "    PATH: #{item["edge"]["source"]["path"]}"
                puts "    EXTENSION: #{item["edge"]["source"]["extension"]}"
                puts "    URL: #{item["edge"]["source"]["url"]}"
                puts "    BROWSER URL: #{item["edge"]["source"]["browser_page_url"]}"
                puts "    BROWSER DOMAIN: #{item["edge"]["source"]["browser_page_domain"]}"
                puts "    BROWSER TITLE: #{item["edge"]["source"]["browser_page_title"]}"
                puts "    HOSTNAME: #{item["edge"]["source"]["hostname"]}"
                puts "    URI: #{item["edge"]["source"]["content_uri"]}"
                puts "    LOCATION: #{item["edge"]["source"]["location"]}"
                puts "    LOCATION OUTLINE: #{item["edge"]["source"]["location_outline"]}"
                puts "    CATEGORY: #{item["edge"]["source"]["category"]}"
                puts "    LINKS: #{item["edge"]["source"]["links"]}"
                puts "    ID: #{item["edge"]["source"]["raw_id"]}"
                puts "    TAGS: #{item["edge"]["source"]["tags_applied"]}"
                puts "    UPLOAD URI: #{item["edge"]["source"]["content_upload_uri"]}"
                puts "    REPORT URI: #{item["edge"]["source"]["content_report_uri"]}"
                puts "    TAGS: #{item["edge"]["source"]["tags_applied"]}"
                puts "    EVENT TYPE: #{item["edge"]["source"]["event_type"]}"
                puts "    SENSOR: #{item["edge"]["source"]["sensor_name"]}"
                puts "    USERNAME: #{item["edge"]["source"]["local_user_name"]}"
                puts "    USER ID: #{item["edge"]["source"]["local_user_sid"]}"
                puts "    LOCAL TIME: #{item["edge"]["source"]["local_time"]}"
                puts "    MACHINE NAME: #{item["edge"]["source"]["local_machine_name"]}"
                puts "    ENDPIONT ID: #{item["edge"]["source"]["endpoint_id"]}"
                puts "    GROUP NAME: #{item["edge"]["source"]["group_name"]}"
                puts "    LOCAL ID: #{item["edge"]["source"]["local_id"]}"
                puts "    BLOCKED: #{item["edge"]["source"]["blocked"]}"
                puts "    DATA SIZE: #{item["edge"]["source"]["data_size"]}"
                puts ""

                puts "  DESTINATION INFORMATION:"
                puts "    PATH: #{item["edge"]["destination"]["path"]}"
                puts "    EXTENSION: #{item["edge"]["destination"]["extension"]}"
                puts "    UPLOAD FILE ID: #{item["edge"]["destination"]["upload_file_id"]}"
                puts "    URL: #{item["edge"]["destination"]["url"]}"
                puts "    BROWSER TITLE: #{item["edge"]["destination"]["browser_page_title"]}"
                puts "    HOSTNAME: #{item["edge"]["destination"]["hostname"]}"
                puts "    MD5: #{item["edge"]["destination"]["md5_hash"]}"
                puts "    FILE SIZE: #{item["edge"]["destination"]["file_size"]}"
                puts "    PATH COMPONENTS: #{item["edge"]["destination"]["path_components"]}"
                puts "    BASENAME: #{item["edge"]["destination"]["path_basename"]}"
                puts "    DOMAIN COMPONENTS: #{item["edge"]["destination"]["domain_components"]}"
                puts "    DOMAIN: #{item["edge"]["destination"]["domain"]}"
                puts "    URI: #{item["edge"]["destination"]["content_uri"]}"
                puts "    LOCATION: #{item["edge"]["destination"]["location"]}"
                puts "    LOCATION OUTLINE: #{item["edge"]["destination"]["location_outline"]}"
                puts "    CATEGORY: #{item["edge"]["destination"]["category"]}"
                puts "    LINKS: #{item["edge"]["destination"]["links"]}"
                puts "    RAW ID: #{item["edge"]["destination"]["raw_id"]}"
                puts "    TAGS: #{item["edge"]["destination"]["tags_applied"]}"
                puts "    CONTENT UPLOAD URI: #{item["edge"]["destination"]["content_upload_uri"]}"
                puts "    CONTENT REPORT URI: #{item["edge"]["destination"]["content_report_uri"]}"
                puts "    EVENT TYPE: #{item["edge"]["destination"]["event_type"]}"
                puts "    SENSOR: #{item["edge"]["destination"]["sensor_name"]}"
                puts "    LOCAL USERNAME: #{item["edge"]["destination"]["local_user_name"]}"
                puts "    LOCAL USERID: #{item["edge"]["destination"]["local_user_sid"]}"
                puts "    LOCAL TIME: #{item["edge"]["destination"]["local_time"]}"
                puts "    LOCAL MACHINE NAME: #{item["edge"]["destination"]["local_machine_name"]}"
                puts "    ENDPOINT ID: #{item["edge"]["destination"]["endpoint_id"]}"
                puts "    GROUP NAMES: #{item["edge"]["destination"]["group_name"]}"
                puts "    BLOCKED: #{item["edge"]["destination"]["blocked"]}"
                puts "    DATA SIZE: #{item["edge"]["destination"]["data_size"]}"
                puts "    LOCAL ID: #{item["edge"]["destination"]["local_id"]}"
                puts "    GDRIVE FILE ID: #{item["edge"]["destination"]["gdrive_file_id"]}"
                puts "    CLOUD PROVIDER: #{item["edge"]["destination"]["cloud_provider"]}"
                puts "    CLOUD APP: #{item["edge"]["destination"]["cloud_app"]}"
                puts "    CLOUD ACCOUNT: #{item["edge"]["destination"]["cloud_app_account"]}"
                puts "    DLP SCAN ID: #{item["edge"]["destination"]["  dlp_scan_linking_id"]}"
                puts ""
            end
        end

    
        ## SUMMARIES -----------------------------------------------------------
        def self.SummaryRaw(incidentID)
            $query ={
                "filters":{
                    "incident_ids": [
                        "#{incidentID}"
                    ],
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
            
            results["incidents"].each do |item|
            $data = {
                values: { 
                "incident_id": " #{item["id"]}".to_s,
                "event_time": " #{item["event_time"]}".to_s,
                "policy_name": "#{item["category"]["name"]}".to_s,
                "policy_severity": " #{item["category"]["severity"]}".to_s,
                "user": "#{item["user"]}".to_s,
                "status": "#{item["resolution_status"]}".to_s,
                "dataset": "#{item["dataset"]["name"]}".to_s,
                "dataset_sensitivity": "#{item["dataset"]["sensitivity"]}".to_i,
                "ploiicy_severity": "#{item["category"]["severity"]}".to_i,
                "create_incident": " #{item["category"]["rule"]["create_incident"]}".to_s,
                "incident_action": "#{item["category"]["rule"]["incident_action"]}".to_s,
                "src_url": "#{item["edge"]["source"]["url"]}".to_s,
                "src_browser_url": "#{item["edge"]["source"]["browser_page_url"]}".to_s,
                "src_browser_domain": " #{item["edge"]["source"]["browser_page_domain"]}".to_s,
                "src_browser_title": "#{item["edge"]["source"]["browser_page_title"]}".to_s,
                "src_location": "#{item["edge"]["destination"]["location"]}".to_s,
                "src_location_outline": "#{item["edge"]["source"]["location_outline"]}".to_s,
                "src_category": "#{item["edge"]["source"]["category"]}".to_s,
                "dst_browser_title": "#{item["edge"]["destination"]["browser_page_title"]}".to_s,
                "dst_basename": "#{item["edge"]["destination"]["path_basename"]}".to_s,
                "dst_domain": "#{item["edge"]["destination"]["domain"]}".to_s,
                "dest_location": "#{item["edge"]["destination"]["location"]}".to_s,
                "dst_location_outline": "#{item["edge"]["destination"]["location_outline"]}".to_s,
                "dst_category": "#{item["edge"]["destination"]["category"]}".to_s,
                "dst_event_type": "#{item["edge"]["destination"]["event_type"]}".to_s,
                "dst_sensor": "#{item["edge"]["destination"]["sensor_name"]}".to_s,
                "dst_local_username": "#{item["edge"]["destination"]["local_user_name"]}".to_s,
                "dst_local_machine_name": "#{item["edge"]["destination"]["local_machine_name"]}".to_s,
                "dst_blocked": "#{item["edge"]["destination"]["blocked"]}".to_s,
                "dst_data_size": "#{item["edge"]["destination"]["data_size"]}".to_s,
                "dst_gdrive_file_id": "#{item["edge"]["destination"]["gdrive_file_id"]}".to_s,
                "dst_cloud_provider": "#{item["edge"]["destination"]["cloud_provider"]}".to_s,
                "dst_cloud_app": "#{item["edge"]["destination"]["cloud_app"]}".to_s,
                "dst_cloud_account": "#{item["edge"]["destination"]["cloud_app_account"]}".to_s,
                }}
                return $data
            end
        end

        def self.SummaryJson(incidentID)
            SummaryRaw("#{incidentID}")
            puts $data.to_json
        end
        
        def self.SummaryYaml(incidentID)
            SummaryRaw("#{incidentID}")
            puts $data.to_yaml
        end

        def self.SummaryReport(incidentID)
            SummaryRaw("#{incidentID}")

            puts "Incident ID: #{$data[:values][:incident_id]}"
            puts "  Event Time: #{$data[:values][:event_time]}" 
            puts "  Policy Name: #{$data[:values][:policy_name]}" 
            puts "  Policy Severity: #{$data[:values][:policy_severity]}"
            puts "  User: #{$data[:values][:user]}"
            puts "  Status: #{$data[:values][:status]}"
            puts "  Dataset Name: #{$data[:values][:dataset]}"
            puts "  Dataset Sensitivity: #{$data[:values][:dataset_sensitivity]}"
            puts "  Policy Severity: #{$data[:values][:ploiicy_severity]}"
            puts "  Create Incident: #{$data[:values][:create_incident]}"
            puts "  Incident Action: #{$data[:values][:incident_action]}"
            puts "  Source Information:"
            puts "    Url: #{$data[:values][:src_url]}"
            puts "    Browser Url: #{$data[:values][:src_browser_url]}"
            puts "    Browser Domain: #{$data[:values][:src_browser_domain]}"
            puts "    Browser Title: #{$data[:values][:src_browser_title]}"
            puts "    Location: #{$data[:values][:src_location]}"
            puts "    Location Outline: #{$data[:values][:src_location_outline]}"
            puts "    Category: #{$data[:values][:src_category]}"
            puts "  Destination Information:"
            puts "    Browser Title: #{$data[:values][:dst_browser_title]}"
            puts "    Basename: #{$data[:values][:dst_basename]}"
            puts "    Domain: #{$data[:values][:dst_domain]}"
            puts "    Location: #{$data[:values][:dest_location]}"
            puts "    Location Outline: #{$data[:values][:dst_location_outline]}"
            puts "    Category: #{$data[:values][:dst_category]}"
            puts "    Event Type: #{$data[:values][:dst_event_type]}"
            puts "    Sensor: #{$data[:values][:dst_sensor]}"
            puts "    Local Username: #{$data[:values][:dst_local_username]}"
            puts "    Local Machine Name: #{$data[:values][:dst_local_machine_name]}"
            puts "    Blocked: #{$data[:values][:dst_blocked]}"
            puts "    Data Size: #{$data[:values][:dst_data_size]}"
            puts "    Google Drive File ID: #{$data[:values][:dst_gdrive_file_id]}"
            puts "    Cloud Provider: #{$data[:values][:dst_cloud_provider]}"
            puts "    Cloud App: #{$data[:values][:dst_cloud_app]}"
            puts "    Cloud Account: #{$data[:values][:dst_cloud_account]}"
        end
    
    end
  end
end
