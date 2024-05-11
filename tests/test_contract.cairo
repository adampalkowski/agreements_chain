

#[cfg(test)]
mod tests {
    use starknet::ContractAddress;

    use snforge_std::{declare, ContractClassTrait};
    
    use agreements_chain::agreement::IAgreementChainDispatcher;
    use agreements_chain::agreement::IAgreementChainDispatcherTrait;
    use agreements_chain::agreement::Agreement;
    #[test]
    fn test_balance(){
        let contract = declare("AgreementChain").unwrap();
        
        let (contract_address, _) = contract.deploy(@array![10000000,10000000]).unwrap();

        let dispatcher = IAgreementChainDispatcher{contract_address};

        let client_balance = dispatcher.get_client_balance();
        let expected_balance :u256 = 10000000;

        assert(client_balance == expected_balance, 'Invalid balance');
        let server_balance = dispatcher.get_server_balance();
        assert(server_balance == expected_balance, 'Invalid balance');
    }   


    #[test]
    fn test_apply_agreement(){
        let contract = declare("AgreementChain").unwrap();
        
        let (contract_address, _) = contract.deploy(@array![10000000,10000000]).unwrap();

        let dispatcher = IAgreementChainDispatcher{contract_address};
        let quantity:felt252 = 1;
        let nonce:felt252 = 0x03a81f6d952dd190fdc9b2270ac85a45c93ce3e95dcb47b84149929e21e91ee7;
        let price:felt252 = 1604;
        let server_signature_r:felt252=0x03a81f6d952dd190fdc9b2270ac85a45c93ce3e95dcb47b84149929e21e91ee7;
        let server_signature_s:felt252=0x0593b5d45fa3e75a4a0721107cce7dbf5ffc4e2bc8f217393f4e50758b3bec76;
        let client_signature_r:felt252=0x03c2a9ad1913d8d67b8f1db8b6875edbde2654619b504e00fb1042328877131f;
        let client_signature_s:felt252=0x006daaab363ec7b1a68fc20fb4183912b2903cee3f9e9885fd95e4c63116d2b1;
        
        let agreement = Agreement{
            quantity:quantity,
            nonce:nonce,
            price:price,
            server_signature_r:server_signature_r,
            server_signature_s:server_signature_s ,
            client_signature_r:client_signature_r,
            client_signature_s:client_signature_s ,
        };

        dispatcher.apply(agreement);

        let agreement = dispatcher.get_agreement_by_id(0);
        assert(agreement == agreement, 'Invalid agreements');
    }   

    #[test]
    fn test_apply_agreement(){
        let contract = declare("AgreementChain").unwrap();
        
        let (contract_address, _) = contract.deploy(@array![10000000,10000000]).unwrap();

        let dispatcher = IAgreementChainDispatcher{contract_address};
        let quantity:felt252 = 1;
        let nonce:felt252 = 0x03a81f6d952dd190fdc9b2270ac85a45c93ce3e95dcb47b84149929e21e91ee7;
        let price:felt252 = 1604;
        let server_signature_r:felt252=0x03a81f6d952dd190fdc9b2270ac85a45c93ce3e95dcb47b84149929e21e91ee7;
        let server_signature_s:felt252=0x0593b5d45fa3e75a4a0721107cce7dbf5ffc4e2bc8f217393f4e50758b3bec76;
        let client_signature_r:felt252=0x03c2a9ad1913d8d67b8f1db8b6875edbde2654619b504e00fb1042328877131f;
        let client_signature_s:felt252=0x006daaab363ec7b1a68fc20fb4183912b2903cee3f9e9885fd95e4c63116d2b1;
        
        let agreement = Agreement{
            quantity:quantity,
            nonce:nonce,
            price:price,
            server_signature_r:server_signature_r,
            server_signature_s:server_signature_s ,
            client_signature_r:client_signature_r,
            client_signature_s:client_signature_s ,
        };

        dispatcher.apply(agreement);

        let agreement = dispatcher.get_agreement_by_id(0);
        assert(agreement == agreement, 'Invalid agreements');
    }   
}
