
### Sui Counter DApp

A simple smart contract written in **Move** for the **Sui blockchain**, demonstrating object ownership, events and timestamped updates using the on-chain `Clock`.

---

## Overview

This dApp defines a `Counter` object that:
 - Belongs to a specific user (address)
 - Stores an integer `value` and a `created_at` timestamp
 - Emits an event every time the counter is incremented

It showcases how to:
 - Use `TxContext` to access the transaction sender
 - Access the on-chain `Clock` module
 - Emit and view custom events in **SuiScan**

---


## Project Structure

sui_counter_dapp/
├── Move.toml
├── sources/
│   └── sui_counter_dapp.move
└── README.md


## Module

`module sui_counter_dapp::sui_counter_dapp`

### Main Structs:
 - **Counter** — stores value, owner, timestamp
 - **CounterCreated** — emitted when a new counter is created
 - **CounterIncremented** — emitted when a counter is incremented



### Functions (Function - Description): 

`create_counter(clock: &Clock, ctx: &mut TxContext)` -  Creates and transfers a new `Counter` object
`increment(counter: &mut Counter, clock: &Clock, ctx: &mut TxContext)` - Increments an existing counter, emits event 
`get_value(counter: &Counter)` -  Returns current counter value



## How to Use


### 1. Build
sui move build


### 2. Publish to testnet
sui client publish --gas-budget 100000000

After running this command, note: 
- PACKAGE_ID


### 3. Create a Counter 
sui client call \
  --package <PACKAGE_ID> \
  --module sui_counter_dapp \
  --function create_counter \
  --args 0x6 \
  --gas-budget 100000000


After running this command, note: 
- COUNTER_OBJECT_ID 
- Transaction hash (Transaction Digest TX_DIGEST)


### 4. Increment the Counter
sui client call \
  --package <PACKAGE_ID> \
  --module sui_counter_dapp \
  --function increment \
  --args <COUNTER_OBJECT_ID> 0x6 \
  --gas-budget 100000000


### 5. Check Counter Value
sui client object <COUNTER_OBJECT_ID>


### 6. Optional: View Emitted Events
sui client tx-block <TX_DIGEST>


### 7. View on SuiScan
Visit https://suiscan.xyz/testnet/home
Search by:
- TX_DIGEST to view the publish result
- PACKAGE_ID → “Events” tab to view emitted events (CounterCreated, CounterIncremented)


## On-Chain Info (Testnet)

PACKAGE_ID: 0x1aa140893c4b3ef0b0a4b161fc55ae45b209741ad49094fd155f362607d62cd0


