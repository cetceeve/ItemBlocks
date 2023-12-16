<script>
  export let contract;
  export let tokenId;
</script>

{#await contract.methods.getPassport(tokenId).call()}
  <article aria-busy="true">loading nft data</article>
{:then data}
  <slot {data}/>
{/await}