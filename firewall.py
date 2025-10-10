class Firewall:
    def __init__(self):
        self.rules = {
            'allow': [],
            'deny': []
        }
    
    def add_rule(self, action, **criteria):
        rule = criteria
        self.rules[action].append(rule)
    
    def check_packet(self, packet):
        for rule in self.rules['deny']:
            if self._matches_rule(packet, rule):
                return False
        for rule in self.rules['allow']:
            if self._matches_rule(packet, rule):
                return True
        return False
    
    def _matches_rule(self, packet, rule):
        for key, value in rule.items():
            if key not in packet or packet[key] != value:
                return False
        return True
