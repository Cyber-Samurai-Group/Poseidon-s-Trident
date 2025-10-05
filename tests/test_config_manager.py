import os
import json
import tempfile
import pytest

import config_manager


def test_load_valid_config(tmp_path):
    config_path = tmp_path / "config.json"
    data = {"key": "value", "number": 42}
    config_path.write_text(json.dumps(data))

    result = config_manager.load_config(str(config_path))
    assert result == data


def test_load_invalid_json(tmp_path):
    config_path = tmp_path / "bad.json"
    config_path.write_text("{invalid_json}")

    with pytest.raises((ValueError, config_manager.ConfigError)):
        config_manager.load_config(str(config_path))


def test_load_missing_file():
    with pytest.raises(FileNotFoundError):
        config_manager.load_config("nonexistent.json")


def test_save_and_reload_config(tmp_path):
    config_path = tmp_path / "saved.json"
    data = {"foo": "bar", "count": 7}

    config_manager.save_config(str(config_path), data)

    assert config_path.exists()
    loaded = json.loads(config_path.read_text())
    assert loaded == data


def test_save_invalid_data(tmp_path):
    config_path = tmp_path / "invalid.json"

    class NonSerializable:
        pass

    with pytest.raises((TypeError, config_manager.ConfigError)):
        config_manager.save_config(str(config_path), NonSerializable())