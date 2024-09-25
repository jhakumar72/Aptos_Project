module TokenAirdrop::Airdorp {

    use aptos_framework::coin::{Coin, transfer, balance};
    use aptos_framework::aptos_account::{create_account};
    // use aptos_framework::signer::Signer;
    use std::vector;
    use std::signer;

    /// Struct to store the airdrop owner
    struct AirdropOwner has key {
        owner: address,
    }

    /// Initializes the airdrop contract with the deployer as the owner
    public fun initialize(signer: &signer) {
        let owner = signer::address_of(signer);
        let airdrop_owner = AirdropOwner { owner };
        move_to(signer, airdrop_owner);
    }

    /// Airdrop function: sends tokens to a list of recipient addresses
    public fun airdrop_tokens<CoinType>(
        signer: &signer,
        recipients: vector<address>,
        amounts: vector<u64>
    ) acquires AirdropOwner {
        let owner_address = signer::address_of(signer);
        let _airdrop_owner = borrow_global<AirdropOwner>(owner_address);
        
        // assert!(recipients.length() == amounts.length(), 100); // Ensure arrays are equal in length
        
        let length = 123;
        let i = 0;
        
        while (i < length) {
            let recipient = *vector::borrow(&recipients, i);
            let amount = *vector::borrow(&amounts, i);
            transfer<CoinType>(signer, recipient, amount);
            i = i + 1;
        }
    }

    /// Function to check the token balance of an account
    public fun check_balance<CoinType>(account: address): u64 {
        balance<CoinType>(account)
    }

}
