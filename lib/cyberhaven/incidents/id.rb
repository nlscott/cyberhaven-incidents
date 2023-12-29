# frozen_string_literal: true

module Cyberhaven
  module Incidents
    module Id

      def self.ReportDetailed(incidentID)
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

      def self.ReportSummary(incidentID)
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
            # puts "  TRIGGER TIME: #{item["trigger_time"]}"
            puts "  POLICY NAME: #{item["category"]["name"]}"
            puts "  POLICY SEVERITY: #{item["category"]["severity"]}"
            puts "  USER: #{item["user"]}"
            puts "  STATUS: #{item["resolution_status"]}"
            # puts "  OUTDATED POLICY: #{item["outdated_policy"]}"
            puts "  FILE: #{item["file"]}"
            puts "  FILE PATH: #{item["data"]["path"]}"
            # puts "  SOURCE DATA: #{item["source_data"]["path"]}"
            # puts "  PERSONAL INFO:"
            # if ! item["personal_info"].nil?
            #     item["personal_info"].each do |personalItem|
            #         puts "    #{personalItem}"
            #     end
            # end
            # puts "  ASSIGNEE: #{item["assignee"]}"
            # puts "  CONTENT TAGS: #{item["content_tags"]}"
            # puts "  RESPONSE: #{item["incident_response"]}"
            # puts "  REACTION: #{item["incident_reactions"]}"
            # puts "  ADMIN HISTORY: #{item["admin_history"]}"
            # puts "  CATEGOERY MODIFIED: #{item["category_last_modified"]}"
            # puts "  DATASET MODIFIED: #{item["dataset_last_modified"]}"
            # puts "  ALERT ID: #{item["alert_id"]}"
            # puts "  SCREENSHOT GUID: #{item["screenshot_guid"]}"
            puts ""
    
            puts "  DATASET:"
            # puts "    ID: #{item["dataset"]["id"]}"
            puts "    NAME: #{item["dataset"]["name"]}"
            puts "    SENSITIVITY: #{item["dataset"]["sensitivity"]}"
            # puts "    LAST MODIFIED: #{item["dataset"]["last_modified"]}"
            puts ""

            puts "  POLICY:"
            # puts "    ID: #{item["category"]["id"]}"
            puts "    NAME: #{item["category"]["name"]}"
            puts "    SEVERITY: #{item["category"]["severity"]}"
            # puts "    DATASET IDS: #{item["category"]["dataset_ids"]}"
            # puts "    EXCLUDE ORIGIN: #{item["category"]["exclude_origin"]}"
            # puts "    LAST MODIFIED: #{item["category"]["last_modified"]}"
            # puts "    SELECTION TYPE: #{item["category"]["selection_type"]}"
            puts "    RULE:"
            # puts "      ID: #{item["category"]["rule"]["id"]}"
            # puts "      STATUS: #{item["category"]["rule"]["status"]}"
            puts "      CREATE INCIDENT: #{item["category"]["rule"]["create_incident"]}"
            puts "      RECORD SCREENSHOT: #{item["category"]["rule"]["record_screenshots"]}"
            puts "      NOTIFY ENABLED: #{item["category"]["rule"]["notify_enabled"]}"
            # puts "      NOTIFY STATUS: #{item["category"]["rule"]["notify_status"]}"
            puts "      NOTIFY EMAIL: #{item["category"]["rule"]["notify_email"]}"
            # puts "      SHOW TITLE: #{item["category"]["rule"]["show_title"]}"
            # puts "      SHOW LOGO: #{item["category"]["rule"]["show_logo"]}"
            puts "      REQUIRE JUSTIFICATION: #{item["category"]["rule"]["require_justification"]}"
            puts "      REQUIRE ACKNOWLEDGEMENT: #{item["category"]["rule"]["should_ack_warning"]}"
            puts "      ALLOW REVIEW: #{item["category"]["rule"]["allow_request_review"]}"
            puts "      OVERRIDE ENABLED: #{item["category"]["rule"]["override_enabled"]}"
            # puts "      BLOCKING ACTION: #{item["category"]["rule"]["blocking_action"]}"
            puts "      INCIDENT ACTION: #{item["category"]["rule"]["incident_action"]}"
            # puts "      WARNING MESSAGE:"
            # puts "        TITLE: #{item["category"]["rule"]["warning_dialog"]["title"]}"
            # puts "        EXPLANATION: #{item["category"]["rule"]["warning_dialog"]["explanation"]}"
            # puts "        PLACEHOLDER: #{item["category"]["rule"]["warning_dialog"]["placeholder"]}"
            # puts "        CHECK TEXT: #{item["category"]["rule"]["warning_dialog"]["check_text"]}"
            # puts "        REVIEW CHECK TEXT: #{item["category"]["rule"]["warning_dialog"]["review_check_text"]}"
            # puts "        SUBMIT LABEL: #{item["category"]["rule"]["warning_dialog"]["submit_label"]}"
            # puts "        ALLOW LABEL: #{item["category"]["rule"]["warning_dialog"]["allow_label"]}"
            # puts "      BLOCKING MESSAGE:"
            # puts "        TITLE: #{item["category"]["rule"]["blocking_dialog"]["title"]}"
            # puts "        EXPLANATION: #{item["category"]["rule"]["blocking_dialog"]["explanation"]}"
            # puts "        PLACEHOLDER: #{item["category"]["rule"]["blocking_dialog"]["placeholder"]}"
            # puts "        CHECK TEXT: #{item["category"]["rule"]["blocking_dialog"]["check_text"]}"
            # puts "        REVIEW CHECK TEXT: #{item["category"]["rule"]["blocking_dialog"]["review_check_text"]}"
            # puts "        SUBMIT LABEL: #{item["category"]["rule"]["blocking_dialog"]["submit_label"]}"
            # puts "        ALLOW LABEL: #{item["category"]["rule"]["blocking_dialog"]["allow_label"]}"
            puts ""
            
            puts "  SOURCE INFORMATION:"
            puts "    PATH: #{item["edge"]["source"]["path"]}"
            puts "    EXTENSION: #{item["edge"]["source"]["extension"]}"
            puts "    URL: #{item["edge"]["source"]["url"]}"
            puts "    BROWSER URL: #{item["edge"]["source"]["browser_page_url"]}"
            puts "    BROWSER DOMAIN: #{item["edge"]["source"]["browser_page_domain"]}"
            puts "    BROWSER TITLE: #{item["edge"]["source"]["browser_page_title"]}"
            # puts "    HOSTNAME: #{item["edge"]["source"]["hostname"]}"
            # puts "    URI: #{item["edge"]["source"]["content_uri"]}"
            puts "    LOCATION: #{item["edge"]["source"]["location"]}"
            puts "    LOCATION OUTLINE: #{item["edge"]["source"]["location_outline"]}"
            puts "    CATEGORY: #{item["edge"]["source"]["category"]}"
            # puts "    LINKS: #{item["edge"]["source"]["links"]}"
            # puts "    ID: #{item["edge"]["source"]["raw_id"]}"
            # puts "    TAGS: #{item["edge"]["source"]["tags_applied"]}"
            # puts "    UPLOAD URI: #{item["edge"]["source"]["content_upload_uri"]}"
            # puts "    REPORT URI: #{item["edge"]["source"]["content_report_uri"]}"
            # puts "    TAGS: #{item["edge"]["source"]["tags_applied"]}"
            # puts "    EVENT TYPE: #{item["edge"]["source"]["event_type"]}"
            # puts "    SENSOR: #{item["edge"]["source"]["sensor_name"]}"
            puts "    USERNAME: #{item["edge"]["source"]["local_user_name"]}"
            # puts "    USER ID: #{item["edge"]["source"]["local_user_sid"]}"
            # puts "    LOCAL TIME: #{item["edge"]["source"]["local_time"]}"
            puts "    MACHINE NAME: #{item["edge"]["source"]["local_machine_name"]}"
            # puts "    ENDPIONT ID: #{item["edge"]["source"]["endpoint_id"]}"
            # puts "    GROUP NAME: #{item["edge"]["source"]["group_name"]}"
            # puts "    LOCAL ID: #{item["edge"]["source"]["local_id"]}"
            puts "    BLOCKED: #{item["edge"]["source"]["blocked"]}"
            puts "    DATA SIZE: #{item["edge"]["source"]["data_size"]}"
            puts ""

            puts "  DESTINATION INFORMATION:"
            puts "    PATH: #{item["edge"]["destination"]["path"]}"
            puts "    EXTENSION: #{item["edge"]["destination"]["extension"]}"
            # puts "    UPLOAD FILE ID: #{item["edge"]["destination"]["upload_file_id"]}"
            puts "    URL: #{item["edge"]["destination"]["url"]}"
            puts "    BROWSER TITLE: #{item["edge"]["destination"]["browser_page_title"]}"
            puts "    HOSTNAME: #{item["edge"]["destination"]["hostname"]}"
            puts "    MD5: #{item["edge"]["destination"]["md5_hash"]}"
            # puts "    FILE SIZE: #{item["edge"]["destination"]["file_size"]}"
            # puts "    PATH COMPONENTS: #{item["edge"]["destination"]["path_components"]}"
            puts "    BASENAME: #{item["edge"]["destination"]["path_basename"]}"
            # puts "    DOMAIN COMPONENTS: #{item["edge"]["destination"]["domain_components"]}"
            puts "    DOMAIN: #{item["edge"]["destination"]["domain"]}"
            # puts "    URI: #{item["edge"]["destination"]["content_uri"]}"
            puts "    LOCATION: #{item["edge"]["destination"]["location"]}"
            puts "    LOCATION OUTLINE: #{item["edge"]["destination"]["location_outline"]}"
            puts "    CATEGORY: #{item["edge"]["destination"]["category"]}"
            # puts "    LINKS: #{item["edge"]["destination"]["links"]}"
            # puts "    RAW ID: #{item["edge"]["destination"]["raw_id"]}"
            # puts "    TAGS: #{item["edge"]["destination"]["tags_applied"]}"
            # puts "    CONTENT UPLOAD URI: #{item["edge"]["destination"]["content_upload_uri"]}"
            # puts "    CONTENT REPORT URI: #{item["edge"]["destination"]["content_report_uri"]}"
            puts "    EVENT TYPE: #{item["edge"]["destination"]["event_type"]}"
            puts "    SENSOR: #{item["edge"]["destination"]["sensor_name"]}"
            puts "    LOCAL USERNAME: #{item["edge"]["destination"]["local_user_name"]}"
            # puts "    LOCAL USERID: #{item["edge"]["destination"]["local_user_sid"]}"
            # puts "    LOCAL TIME: #{item["edge"]["destination"]["local_time"]}"
            puts "    LOCAL MACHINE NAME: #{item["edge"]["destination"]["local_machine_name"]}"
            # puts "    ENDPOINT ID: #{item["edge"]["destination"]["endpoint_id"]}"
            # puts "    GROUP NAMES: #{item["edge"]["destination"]["group_name"]}"
            puts "    BLOCKED: #{item["edge"]["destination"]["blocked"]}"
            puts "    DATA SIZE: #{item["edge"]["destination"]["data_size"]}"
            # puts "    LOCAL ID: #{item["edge"]["destination"]["local_id"]}"
            puts "    GDRIVE FILE ID: #{item["edge"]["destination"]["gdrive_file_id"]}"
            puts "    CLOUD PROVIDER: #{item["edge"]["destination"]["cloud_provider"]}"
            puts "    CLOUD APP: #{item["edge"]["destination"]["cloud_app"]}"
            puts "    CLOUD ACCOUNT: #{item["edge"]["destination"]["cloud_app_account"]}"
            # puts "    DLP SCAN ID: #{item["edge"]["destination"]["  dlp_scan_linking_id"]}"
            puts ""
        end
      end
      
    end
  end
end
