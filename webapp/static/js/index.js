// const mmsdk = new MetaMaskSDK.MetaMaskSDK();
// const web3 = new Web3(Web3.givenProvider);

async function connect() {
    //console.log(ethereum)
    //const ethereum = mmsdk.getProvider();

    accounts = await ethereum
        .request({
            method: 'eth_requestAccounts',
            params: [],
        })
    console.log(accounts)
    return accounts;
}
