<script>
  import { Web3 } from "web3";
  import ABI from "../assets/ABI.json";
  import PassportCard from "./PassportCard.svelte";
  import PassportForm from "./PassportForm.svelte";
  import QRCode from 'qrcode'

  export let tokenId;
  export let activeAcc;
  let edit = false;

  let params = new URL(document.location).searchParams;
  let qrcode = params.get("qrcode") == "true" ? true : false;

  const web3 = new Web3(window.ethereum);
  const contract = new web3.eth.Contract(
    ABI,
    "0x619b0cC263C1c64aD7cB0b73527b8C1795F4899d",
  );

  async function getItemData(uri) {
    const response = await fetch(uri);
    console.log(response);
    const data = await response.json();
    console.log(data);
    return data;
  }

  async function updatePassport(updated) {
    // we are deliberatly not doing any error handling here as it will be done in the form component
    if (!activeAcc) {
      throw "Please connect to a wallet!";
    }
    return await contract.methods.updatePassport(
      tokenId, updated.name, updated.desc, updated.family, updated.url, updated.img
    ).send({from: activeAcc});
  }
  
  async function generateQR(text) {
    console.log(text);
    return await QRCode.toDataURL(text);
  }
</script>

{#await contract.methods.getPassport(tokenId).call()}
  <article aria-busy="true">loading nft data</article>
{:then data}
  {#if edit}
    <article>
      <header>Edit the item</header>
      <PassportForm {...data}
        onSubmit={(values) => updatePassport(values)}
        closeForm={() => {edit = false}}/>
    </article>
  {:else}
    <PassportCard {...data}/>
    <button class="outline" on:click={() => {qrcode = true}}>Show QR code</button>
    <button class="outline" on:click={() => {edit = true}}>EDIT</button>
  {/if}
{/await}

<dialog open={qrcode}>
  <div>
    {#await generateQR(window.location.origin + window.location.pathname) then qrCodeUri}
      <img src={qrCodeUri} alt="QrCode"/>
    {:catch err}
      <p>Sorry! Something went wrong!</p>
    {/await}
    <button on:click={() => {qrcode = false}}>Close</button>
  </div>
</dialog>