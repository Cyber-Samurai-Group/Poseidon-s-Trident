from firewall import Firewall

def test_firewall_rule_parsing():
    rules = ["ALLOW tcp 80", "DENY udp 53"]
    fw = Firewall()
    # Parse and add rules
    for rule_str in rules:
        action, proto, port = rule_str.split()
        fw.add_rule(action.lower(), proto=proto, port=int(port))

    # Simulate packet checks
    tcp_packet = {"proto": "tcp", "port": 80}
    udp_packet = {"proto": "udp", "port": 53}

    assert fw.check_packet(tcp_packet) is True
    assert fw.check_packet(udp_packet) is False
