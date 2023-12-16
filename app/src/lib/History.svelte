<script>
  export let tokenId;
  export let contract;
  import Web3 from "web3";
    import PassportCard from "./PassportCard.svelte";
    import { Link } from "svelte-routing";
  const web3 = new Web3(window.ethereum);

  //let etherscanURL = `https://api.etherscan.io/api?module=logs&action=getLogs&fromBlock=10221728&toBlock=${web3.eth.getBlockNumber()}&address=0x5f0B6625541d613ea33098d2afdE2aE466dbF1ec&topic0=${web3.eth.abi.encodeEventSignature('PassportUpdate(uint256,address,uint8,string,string,string,string,string)')}&topic0_1_opr=and&topic1=${web3.eth.abi.encodeParameter("uint256", tokenId)}&page=1&offset=10&apikey=8GMF6CSE9AW2BQ2T5XZHT5BGJPBQSSY29H`;
  //console.log(etherscanURL)
  //fetch(etherscanURL).then((res) => res.json()).then((data) => console.log(data)).catch((err) => console.error(err))

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
      <h5>{"Block Number: " + event.blockNumber}</h5>
      <PassportCard 
        name={event.returnValues.name}
        desc={event.returnValues.desc} 
        family={event.returnValues.family}
        url={event.returnValues.url}
        img={event.returnValues.img}/>
        <small>Edited By:</small>
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