<script>
  import PassportCard from "./PassportCard.svelte";
  import PassportForm from "./PassportForm.svelte";
  import QRCode from 'qrcode'
    import PassportLoader from "./PassportLoader.svelte";

  export let tokenId;
  export let activeAcc;
  export let contract;
  let edit = false;

  let params = new URL(document.location).searchParams;
  let qrcode = params.get("qrcode") == "true" ? true : false;

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

<PassportLoader {contract} {tokenId} let:data>
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
</PassportLoader>

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