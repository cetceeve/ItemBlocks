<script>
  export let tokenId;
  export let activeAcc;
  let edit = false;

  import { Web3 } from "web3";
  import ABI from "../assets/ABI.json";
  import { Link, Route } from "svelte-routing";
  import PassportCard from "./PassportCard.svelte";
  import PassportForm from "./PassportForm.svelte";

  const web3 = new Web3(window.ethereum);
  const contract = new web3.eth.Contract(
    ABI,
    "0x594878fC30ED30a2992eF7bDcD033C20515Aa5de",
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
</script>

{#await contract.methods.getPassport(parseInt(tokenId)).call()}
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
    <button class="outline" on:click={() => {edit = true}}>EDIT</button>
  {/if}
{/await}