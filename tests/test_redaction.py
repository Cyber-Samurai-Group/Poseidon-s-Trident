import pytest
from logger import Logger

def test_redaction():
    log = Logger()
    log.log("User login with password=123 token=abc", "INFO")
    logs = log.get_logs()

    # Check sensitive info is redacted
    assert any("password=[REDACTED]" in entry for entry in logs)
    assert any("token=[REDACTED]" in entry for entry in logs)

    # Check original values are gone
    for entry in logs:
        assert "123" not in entry
        assert "abc" not in entry
