import pytest
from firewall import Firewall

@pytest.fixture
def firewall_setup():
    """Pytest fixture for firewall setup"""
    fw = Firewall()
    
    # Add some default rules
    fw.add_rule('allow', src_ip='192.168.1.10', port=80)
    fw.add_rule('allow', src_ip='192.168.1.20', port=443)
    fw.add_rule('deny', src_ip='10.0.0.5', port=22)
    
    return fw

def test_allow_rules(firewall_setup):
    """Test that allow rules work correctly"""
    fw = firewall_setup
    
    # Test allowed traffic
    allowed_packet = {'src_ip': '192.168.1.10', 'port': 80}
    assert fw.check_packet(allowed_packet) == True
    
    https_packet = {'src_ip': '192.168.1.20', 'port': 443}
    assert fw.check_packet(https_packet) == True

def test_deny_rules(firewall_setup):
    """Test that deny rules work correctly"""
    fw = firewall_setup
    
    # Test denied traffic
    denied_packet = {'src_ip': '10.0.0.5', 'port': 22}
    assert fw.check_packet(denied_packet) == False

def test_default_deny(firewall_setup):
    """Test default deny behavior"""
    fw = firewall_setup
    
    # Traffic not matching any rule should be denied
    unknown_packet = {'src_ip': '192.168.1.100', 'port': 8080}
    assert fw.check_packet(unknown_packet) == False

def test_simulated_traffic_scenarios(firewall_setup):
    """Test firewall with simulated traffic scenarios"""
    fw = firewall_setup
    
    # Simulate multiple packets
    traffic = [
        {'src_ip': '192.168.1.10', 'port': 80, 'expected': True},
        {'src_ip': '10.0.0.5', 'port': 22, 'expected': False},
        {'src_ip': '192.168.1.20', 'port': 443, 'expected': True},
        {'src_ip': '172.16.0.1', 'port': 21, 'expected': False}
    ]
    
    for packet in traffic:
        expected = packet.pop('expected')
        result = fw.check_packet(packet)
        assert result == expected, f"Packet {packet} failed test"