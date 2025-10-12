import logging
import logging.config
import yaml
from pathlib import Path
import re

SENSITIVE_KEYS = ["password", "token", "secret"]

def redact_sensitive_data(message: str) -> str:
    """Redact sensitive keys in a log message."""
    for key in SENSITIVE_KEYS:
        pattern = re.compile(rf"({key})\s*=\s*[^,\s]+", re.IGNORECASE)
        message = pattern.sub(r"\1=[REDACTED]", message)
    return message

def setup_logging(config_path="logging_config.yaml"):
    if Path(config_path).exists():
        with open(config_path, "r") as f:
            config = yaml.safe_load(f)
        logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=logging.INFO)

logger = logging.getLogger("poseidon")

class Logger:
    def __init__(self):
        # Initialize an empty list to store log messages
        self.log_messages = []

    def log(self, message, level):
        """
        Log a message with the specified level.

        Args:
            message (str): The log message.
            level (str): The log level (e.g., "INFO", "WARNING", "ERROR").
        """
        # Append the log redacted message to the list
        redacted_message = redact_sensitive_data(message)
        self.log_messages.append(f"[{level}] {redacted_message}")

    def get_logs(self):
        """
        Get all logged messages.

        Returns:
            list: A list of log messages.
        """
        return self.log_messages

# Example usage
if __name__ == "__main__":
    logger = Logger()
    logger.log("Initializing application", "INFO")
    logger.log("User login failed with password=123456 and token=abcdef", "WARNING")
    logger.log("Error occurred during processing", "ERROR")

    # Get all logs
    all_logs = logger.get_logs()
    for log in all_logs:
        print(log)
