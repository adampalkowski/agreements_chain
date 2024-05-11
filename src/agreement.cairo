use starknet::ContractAddress;

#[derive(Drop, Serde,starknet::Store,PartialEq)]
pub struct Agreement {
    pub quantity: felt252,
    pub nonce: felt252,
    pub price: felt252,
    pub server_signature_r: felt252,
    pub server_signature_s: felt252,
    pub client_signature_r: felt252,
    pub client_signature_s: felt252,
}

#[starknet::interface]
pub trait IAgreementChain<TContractState> {
    fn apply(ref self: TContractState, agreement:Agreement) -> felt252;
    fn get_client_balance(self: @TContractState)-> u256;
    fn get_server_balance(self: @TContractState)-> u256;
    fn get_agreement_by_id(self: @TContractState,id:felt252)-> Agreement;
}

#[starknet::contract]
mod AgreementChain {
    use agreements_chain::agreement::Agreement;
    #[storage]
    struct Storage {
        client_balance:u256,
        server_balance:u256,
        agreements_len: felt252,
        agreements: LegacyMap::<felt252, Agreement>,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        client_balance: felt252,
        server_balance: felt252,
    ) {
        self.client_balance.write(client_balance.into());
        self.server_balance.write(server_balance.into());
    }

    
    #[abi(embed_v0)]
    impl AgreementChainImpl of super::IAgreementChain<ContractState> {
        fn apply(ref self: ContractState, agreement: Agreement) -> felt252 {
            let agreement_id = self.agreements_len.read();
            self
            .agreements
            .write(
                agreement_id,
                agreement
            );
            self.agreements_len.write(agreement_id + 1);
            agreement_id
        }     

        fn get_client_balance(self: @ContractState)  -> u256 {
            self.client_balance.read()
        }
        fn get_server_balance(self: @ContractState)  -> u256 {
            self.server_balance.read()
        }
        fn get_agreement_by_id(self: @ContractState,id:felt252)  -> Agreement {
            self.agreements.read(id)
        }
    }
}