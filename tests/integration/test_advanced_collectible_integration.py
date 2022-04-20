from brownie import network, AdvancedCollectible
import time
import pytest
from scripts.helpful_scripts import (
    LOCAL_BLOCKCHAIN_ENVIRONMENTS, 
    get_contract, 
    get_account,
    get_breed
)
from scripts.advanced_collectible.deploy_and_create import deploy_and_create

def test_can_create_advanced_collectible_integration():
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing")
    advanced_collectible, creation_transaction = deploy_and_create()
    time.sleep(60)
    assert advanced_collectible.tokenCounter == 1

def test_get_breed():
    breed = get_breed(0)
    assert breed == "PUG"