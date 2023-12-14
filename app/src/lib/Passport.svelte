<script>
  export let id;
  export let activeAcc;

  import { Web3 } from "web3";
  import ABI from "../assets/ABI.json";

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
<article aria-busy="true">
  loading nft data
</article>
{:then data}
<article>
  <header><strong>{data.name}</strong></header>
  {#if data.img}
    <img src={data.img} alt="thumbnail"/>
  {/if}
  <p>{data.desc}</p>
  <a href={data.url} role="button" class="secondary itemlink">Item Website</a>
  <footer>{data.family}</footer>
</article>
{/await}

<style>
.itemlink {
  width: 100%;
}
</style>