<script>
  import PassportForm from "./PassportForm.svelte"; 
  import { navigate } from "svelte-routing";
  
  export let activeAcc;
  export let contract;
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
  <header><strong>Create a new item passport</strong></header>
  <PassportForm
    name=""
    desc=""
    family=""
    url=""
    img=""
    onSubmit={(values) => createPassport(values)}
    onSuccess={() => navigate("/item/" + tokenId + "/?qrcode=true", {replace: true})}
    closeForm={() => navigate("/", {replace: true})}
  />
</article>
