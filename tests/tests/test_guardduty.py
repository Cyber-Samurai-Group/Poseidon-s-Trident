import pytest
from moto import mock_guardduty
import boto3
def parse_guardduty_event(event):
return {
"id": event.get("id"),
"type": event.get("type"),
"severity": event.get("severity"),
}
def handle_alert(event):
if event["severity"] > 5:
return "High severity alert"
return "Low severity alert"
@mock_guardduty
def test_guardduty_event_parsing_and_alerts():
# Set up mocked GuardDuty client
client = boto3.client("guardduty", region_name="us-east-1")
# Create a detector in mocked GuardDuty  
detector_id = client.create_detector(Enable=True)["DetectorId"]  
assert detector_id is not None  

# Fake GuardDuty finding (event)  
event = {  
    "id": "finding-123",  
    "type": "UnauthorizedAccess:EC2/MaliciousIPCaller.Custom",  
    "severity": 8,  
}  

# Test parsing  
parsed = parse_guardduty_event(event)  
assert parsed["id"] == "finding-123"  
assert parsed["type"].startswith("UnauthorizedAccess")  

# Test alert handling  
result = handle_alert(parsed)  
assert result == "High severity alert"  
