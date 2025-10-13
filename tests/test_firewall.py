import pytest
from src.firewall import Firewall

@pytest.fixture
def firewall_instance():
    """Fixture to initialize the firewall with example rules."""
    rules = ["ALLOW tcp 80", "DENY udp 53"]
    return Firewall(rules)

def test_firewall_allow_and_deny(firewall_instance):
    """Test that ALLOW and DENY rules work correctly."""
    assert firewall_instance.is_allowed("tcp", 80) is True
    assert firewall_instance.is_allowed("udp", 53) is False

def test_firewall_default_deny(firewall_instance):
    """Unspecified ports/protocols should be denied by default."""
    assert firewall_instance.is_allowed("tcp", 22) is False
    assert firewall_instance.is_allowed("udp", 9999) is False

def test_firewall_invalid_rule_format():
    """Invalid rule formats should raise ValueError."""
    fw = Firewall()
    with pytest.raises(ValueError):
        fw.add_rule("ALLOW tcp")  # Missing port
    with pytest.raises(ValueError):
        fw.add_rule("PERMIT tcp 80")  # Invalid action

def test_firewall_dynamic_rule_addition():
    """Test that adding new rules dynamically updates firewall behavior."""
    fw = Firewall()
    fw.add_rule("ALLOW udp 8080")
    assert fw.is_allowed("udp", 8080) is True
    fw.add_rule("DENY udp 8080")
    assert fw.is_allowed("udp", 8080) is False

def test_firewall_simulated_traffic(firewall_instance):
    """
    Simulate traffic and verify behavior.
    This mimics sending packets with various protocols/ports.
    """
    simulated_packets = [
        {"protocol": "tcp", "port": 80, "expected": True},
        {"protocol": "udp", "port": 53, "expected": False},
        {"protocol": "tcp", "port": 443, "expected": False},
    ]

    for pkt in simulated_packets:
        result = firewall_instance.is_allowed(pkt["protocol"], pkt["port"])
        assert result == pkt["expected"], f"Failed for {pkt}"

