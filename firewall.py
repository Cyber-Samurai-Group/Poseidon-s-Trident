"""
Simple Firewall logic for Poseidon's Trident.
Parses rules like:
    ALLOW tcp 80
    DENY udp 53
and exposes is_allowed(protocol, port).
Default behavior: deny if no matching rule.
"""

class Firewall:
    def __init__(self, rules=None):
        """
        Initialize firewall with an optional list of rules.
        Example:
            rules = ["ALLOW tcp 80", "DENY udp 53"]
        """
        self.rules = []
        if rules:
            for rule in rules:
                self.add_rule(rule)

    def add_rule(self, rule_str: str):
        """Parse a rule string and add it to the rule list."""
        parts = rule_str.strip().split()
        if len(parts) != 3:
            raise ValueError(f"Invalid rule format: {rule_str}")
        
        action, protocol, port = parts
        action = action.upper()
        protocol = protocol.lower()

        if action not in {"ALLOW", "DENY"}:
            raise ValueError(f"Invalid action: {action}")
        try:
            port = int(port)
        except ValueError:
            raise ValueError(f"Port must be integer in rule: {rule_str}")

        self.rules.append({
            "action": action,
            "protocol": protocol,
            "port": port
        })

    def is_allowed(self, protocol: str, port: int) -> bool:
        """
        Check if given protocol/port is allowed.
        Returns True if ALLOW rule matches, False if DENY rule matches,
        or False if no rules match (default deny).
        """
        protocol = protocol.lower()
        for rule in self.rules:
            if rule["protocol"] == protocol and rule["port"] == port:
                return rule["action"] == "ALLOW"
        # Default deny if no match
        return False

