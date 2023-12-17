<script>
  export let tokenId;
  export let contract;
  import Web3 from "web3";
    import PassportCard from "./PassportCard.svelte";
    import { Link } from "svelte-routing";
  const web3 = new Web3(window.ethereum);

  async function getHistory() {
    let history = await contract.getPastEvents("PassportUpdate", {
      filter: {
        tokenId: tokenId,
        //myOtherIndexedParam: "0x123456789...",
      }, // Using an array means OR: e.g. 20 or 23
      fromBlock: 10221728,
      toBlock: "latest",
    });
    console.log(history);
    return history;
  }
</script>

<div>
  <Link to={"/item/" + tokenId}>
    <button>Back to Item</button>
  </Link>
  {#await getHistory()}
    <p>loading events</p>
  {:then events}
    {#each events.reverse() as event}
      <hr />
      <h5>Block Number: 
        <a class="ownerlink" href={"https://etherscan.io/block/" + event.blockNumber}>{event.blockNumber}</a>
      </h5>
      <PassportCard 
        name={event.returnValues.name}
        desc={event.returnValues.desc} 
        family={event.returnValues.family}
        url={event.returnValues.url}
        img={event.returnValues.img}/>
      <h5 style:margin-bottom="0">Edited By:</h5>
      <figure>
        <a class="ownerlink" href={"https://etherscan.io/address/" + event.returnValues.editor}>{event.returnValues.editor}</a>
      </figure>
    {/each}
  {/await}
</div>

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