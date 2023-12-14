<script>
  export let id;
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
</script>

<span>{activeAcc}</span>
{#await contract.methods.getPassport(parseInt(id)).call()}
  <article aria-busy="true">loading nft data</article>
{:then data}
  {#if edit}
    <article>
      <header>Edit the item</header>
      <PassportForm {...data} onSubmit={(values, context) => {edit = false}}/>
    </article>
  {:else}
    <PassportCard {...data}/>
    <button class="outline" on:click={() => {edit = true}}>EDIT</button>
  {/if}
{/await}