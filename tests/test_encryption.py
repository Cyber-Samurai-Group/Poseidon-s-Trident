import pytest
from encryption import Encryption

from cryptography.fernet import Fernet

def test_encrypt_decrypt_roundtrip():
    key = Fernet.generate_key()
    encryptor = Encryption(key=key)
    msg = "secret!"
    encrypted = encryptor.encrypt(msg)
    decrypted = encryptor.decrypt(encrypted)
    assert decrypted == msg
