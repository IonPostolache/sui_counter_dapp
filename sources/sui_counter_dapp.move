/*
/// Module: sui_counter_dapp
module sui_counter_dapp::sui_counter_dapp;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions



module sui_counter_dapp::sui_counter_dapp {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui:: transfer;
    use sui::event;
    use sui::clock;

    /// The Counter object holds a single integer value.
    public struct Counter has key {
        id: UID,
        owner: address,
        value: u64,
        created_at: u64,
    }

    public struct CounterCreated has copy, drop {owner: address}
    public struct CounterIncremented has copy, drop {owner: address, new_value: u64, timestamp: u64}

    /// Initializes a new Counter object with the given initial value.
    public entry fun create_counter(clock: &clock::Clock, ctx: &mut TxContext) {
        let now = clock::timestamp_ms(clock);
        let sender = tx_context::sender(ctx);
        let counter = Counter {
            id: object::new(ctx),
            owner: sender,
            value: 0,
            created_at: now,
        };
        event::emit<CounterCreated>(CounterCreated { owner: sender });
        transfer::transfer(counter, sender);        
    }

    /// Increments the value of the given Counter object by 1.
    public entry fun increment(counter: &mut Counter, clock: &clock::Clock, ctx: &mut TxContext) {
        counter.value = counter.value + 1;

        let now = clock::timestamp_ms(clock);
        
        event::emit<CounterIncremented>(CounterIncremented { 
            owner: counter.owner, 
            new_value: counter.value,
            timestamp: now
             });
    }

    /// Retrieves the current value of the given Counter object.
    public fun get_value(counter: &Counter): u64 {
        counter.value
    }
}


