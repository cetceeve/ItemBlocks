<script>
  export let activeAcc;
  import PassportForm from "./PassportForm.svelte"; 
  import { NibbleWidthError, Web3 } from "web3";
  import ABI from "../assets/ABI.json";
  import { navigate } from "svelte-routing";
  
  // credit
  // https://stackoverflow.com/questions/63163468/generate-a-256-bit-random-number
  function rnd256() {
    const bytes = new Uint8Array(32);
    
    // load cryptographically random bytes into array
    window.crypto.getRandomValues(bytes);
    
    // convert byte array to hexademical representation
    const bytesHex = bytes.reduce((o, v) => o + ('00' + v.toString(16)).slice(-2), '');
    
    // convert hexademical value to a decimal string
    return BigInt('0x' + bytesHex).toString(10);
  }

  let tokenId = rnd256();

  const web3 = new Web3(window.ethereum);
  const contract = new web3.eth.Contract(
    ABI,
    "0xC63B8240EA75622Db719792f69FED0bf160c58d8",
  );

  async function createPassport(created) {
    // we are deliberatly not doing any error handling here as it will be done in the form component
    if (!activeAcc) {
      throw "Please connect to a wallet!";
    }
    return await contract.methods.createPassport(
      tokenId, created.name, created.desc, created.family, created.url, created.img
    ).send({from: activeAcc});
  }
</script>

<article>
  <header>Create a new item passport</header>
  <PassportForm
    name=""
    desc=""
    family=""
    url=""
    img=""
    onSubmit={(values) => createPassport(values)}
    closeForm={() => navigate("/item/" + tokenId + "/?qrcode=true", {replace: true})}
  />
</article>
