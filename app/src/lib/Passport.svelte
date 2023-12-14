<script>
  export let id;
  export let activeAcc;

  import { Web3 } from "web3";
  import ABI from "../assets/ABI.json";

  const web3 = new Web3(window.ethereum);
  const contract = new web3.eth.Contract(
    ABI,
    "0x284C8BE822b227b5353fB75063Dd11A34D324b83",
  );

  async function getItemData(uri) {
    const response = await fetch(uri);
    const data = await response.json();
    console.log(data);
    return data;
  }
</script>

<span>{activeAcc}</span>
{#await contract.methods.tokenURI(parseInt(id)).call()}
  <article aria-busy="true">
    loading nft uri
  </article>
{:then uri}
  {#await getItemData(uri)}
  <article aria-busy="true">
    loading nft uri
  </article>
  {:then data}
  <article>
    <header><strong>{data.name}</strong></header>
    {#if data.img}
      <img src={data.img} alt="thumbnail"/>
    {/if}
    <p>{data.desc}</p>
    <a href={data.url} role="button" class="secondary itemlink">Item Website</a>
    <footer>{data.type}</footer>
  </article>
  {/await}
{/await}

<style>
.itemlink {
  width: 100%;
}
</style>