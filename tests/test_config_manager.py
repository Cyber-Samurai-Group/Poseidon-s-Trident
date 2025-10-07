import os
import json
import pytest
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from config_manager import ConfigManager

TEST_CONFIG_PATH = "test_config.json"

@pytest.fixture
def manager():
    if os.path.exists(TEST_CONFIG_PATH):
        os.remove(TEST_CONFIG_PATH)
        
    yield ConfigManager(TEST_CONFIG_PATH)
    
    # Clean up after the test
    if os.path.exists(TEST_CONFIG_PATH):
        os.remove(TEST_CONFIG_PATH)

@pytest.fixture
def valid_test_data():
    return {
        "key1": "value1",
        "number_setting": 123,
        "security_level": "medium",  
        "firewall_enabled": True
    }

"""Test saving and loading a valid configuration"""
def test_save_and_load_valid_config(manager, valid_test_data):
    manager.save_config(valid_test_data)
    assert os.path.exists(TEST_CONFIG_PATH)
    with open(TEST_CONFIG_PATH, "r") as f:
        content = json.load(f)
        assert content == valid_test_data
    loaded_config = manager.load_config()
    assert loaded_config == valid_test_data
    assert manager.config == valid_test_data

"""Test for attempting to load a non-existent file"""
def test_load_config_file_not_found():
    non_existent_path = "non_existent_config.json"
    manager = ConfigManager(non_existent_path)
    with pytest.raises(FileNotFoundError, match=f"Config file not found: {non_existent_path}"):
        manager.load_config()

"""Test when the config file contains invalid JSON"""
def test_load_config_invalid_json(manager):
    with open(TEST_CONFIG_PATH, "w") as f:
        f.write("{'key': 'value'")
    with pytest.raises(json.JSONDecodeError):
        manager.load_config()

"""Test error handling during save_config by simulating a permission error"""
def test_save_config_exception(manager, mocker):

    mocker.patch(
        "builtins.open", 
        side_effect=OSError("Permission Denied")
    )
    with pytest.raises(OSError, match="Permission Denied"):
        manager.save_config({"data": "test"})
            

"""Test successful configuration update and internal calls for update_config method"""
def test_update_config_success(manager, mocker):
    initial_config = {"security_level": "low", "firewall_enabled": False, "old_key": 1}
    manager.config = initial_config.copy()
    
    new_updates = {
        "security_level": "high",
        "firewall_enabled": True,
        "new_key": "new_value"
    }
    
    mock_detect = mocker.patch.object(manager, 'detect_threats')
    mock_protect = mocker.patch.object(manager, 'protect_system')
    mock_respond = mocker.patch.object(manager, 'respond_to_incidents')

    manager.update_config(new_updates)

    mock_detect.assert_called_once_with(new_updates)
    mock_protect.assert_called_once_with(new_updates)
    mock_respond.assert_called_once_with(new_updates)

    expected_config = {**initial_config, **new_updates}
    assert manager.config == expected_config

"""Test update_config failure due to a missing required key"""
def test_update_config_missing_required_key_failure(manager):
    invalid_updates = {
        "security_level": "high",
        "encryption": "AES256"
    }
    with pytest.raises(ValueError, match="Missing required config key: firewall_enabled"):
        manager.update_config(invalid_updates)
    assert manager.config == {} 

"""Directly test detect_threats with valid data"""
def test_detect_threats_success(manager):
    
    valid_config = {"security_level": "high", "firewall_enabled": True}
    manager.detect_threats(valid_config)


"""Tests the 'data' = config if config is not None branch in save_config method"""
def test_save_config_uses_internal_config_when_none_passed(manager, valid_test_data):
    manager.config = valid_test_data
    manager.save_config()
    with open(TEST_CONFIG_PATH, "r") as f:
        content = json.load(f)
        assert content == valid_test_data

"""Tests the Exception in update_config method"""
def test_update_config_error_handling(manager, mocker):
    
    valid_updates = {"security_level": "low", "firewall_enabled": True}
    mocker.patch.object(manager, 'protect_system', side_effect=RuntimeError("System lockdown failed"))
    with pytest.raises(RuntimeError, match="System lockdown failed"):
        manager.update_config(valid_updates)

"""Tests the 'else' branch where firewall_enabled is False in protect_system method"""
def test_protect_system_firewall_disabled(manager, mocker):
    config_disabled = {"firewall_enabled": False, "security_level": "high"}
    manager.protect_system(config_disabled) 
    config_missing = {"security_level": "high"}
    manager.protect_system(config_missing)
    
"""Tests the 'else' branch where security_level is not 'high' in respond_to_incedents method"""
def test_respond_to_incidents_standard_mode(manager):
    config_low = {"security_level": "low", "firewall_enabled": True}
    manager.respond_to_incidents(config_low)
    config_missing = {"firewall_enabled": True}
    manager.respond_to_incidents(config_missing)