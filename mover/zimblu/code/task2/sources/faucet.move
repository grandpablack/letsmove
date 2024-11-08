module task2::zimbluFaucet {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::url::{Self,Url};

    public struct ZIMBLUFAUCET has drop {}

    #[allow(lint(share_owned))]
    fun init(witness: ZIMBLUFAUCET, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<ZIMBLUFAUCET>(
            witness,
            9,
            b"ZIMBLUFAUCET",
            b"ZIMBLUFAUCET",
            b"faucet coin defined by zimblu",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/94040354?v=4")),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(treasury_cap)
    }
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<ZIMBLUFAUCET>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }
    public fun burn(
        treasury_cap: &mut TreasuryCap<ZIMBLUFAUCET>, 
        coin: Coin<ZIMBLUFAUCET>
    ) {
        coin::burn(treasury_cap, coin);
    }
}