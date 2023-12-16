<script>
  import PassportCard from "./PassportCard.svelte";
  import PassportForm from "./PassportForm.svelte";
  import PassportLoader from "./PassportLoader.svelte";
  import QRCode from 'qrcode'
    import TransferOwner from "./TransferOwner.svelte";

  export let tokenId;
  export let activeAcc;
  export let contract;
  let edit = false;
  let ownershipHistory = false;
  let transferDialog = false;

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
    <button class="outline" on:click={() => {ownershipHistory = true}}>Show Ownership History</button>
    <button class="outline" on:click={() => {transferDialog = true}}>Change Ownership</button>
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

<dialog open={ownershipHistory}>
  <div class="container">
    {#await contract.methods.getUserHistory(tokenId).call()}
      <p aria-busy="true">fetching history</p>
    {:then owners}
      {#each owners as owner}
        <figure>
          <a class="ownerlink" href={"https://etherscan.io/address/" + owner}>{owner}</a>
        </figure>
        <hr />
      {/each}
    {/await}
    <button on:click={() => {ownershipHistory = false}}>Close</button>
  </div>
</dialog>

<dialog open={transferDialog}>
  <div class="container">
    <button class="outline" on:click={() => {transferDialog = false}}>Close</button>
    <TransferOwner {contract} {activeAcc} {tokenId}
      closeForm={() => {transferDialog = false; ownershipHistory = true;}}/>
  </div>
</dialog>

<style>
  hr {
    display: block;
    height: 1px;
    border: 0;
    border-top: 1px solid #ccc;
    margin: 1em 0;
    padding: 0;
  }

  .ownerlink {
    white-space: nowrap;
  }
 
 
</style>