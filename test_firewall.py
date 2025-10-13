import pytest

class Firewall:
    def __init__(self):
        self.allowed = set()
        self.denied = set()

    def allow(self, ip):
        self.allowed.add(ip)

    def deny(self, ip):
        self.denied.add(ip)

    def check(self, ip):
        if ip in self.denied:
            return False
        if ip in self.allowed:
            return True
        return None


@pytest.fixture
def firewall():
    fw = Firewall()
    fw.allow("192.168.1.1")
    fw.deny("10.0.0.1")
    return fw


def test_allow_rule(firewall):
    assert firewall.check("192.168.1.1") is True


def test_deny_rule(firewall):
    assert firewall.check("10.0.0.1") is False


def test_unknown_rule(firewall):
    assert firewall.check("8.8.8.8") is None
