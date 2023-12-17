<script>
  export let name;
  export let desc;
  export let family;
  export let url;
  export let img;
  export let contract;
  export let tokenId;
  export let showOwner = false;
</script>

<article>
  <header>
    <hgroup style:margin-bottom="0">
      <h3>{name}</h3>
      <h4>{family}</h4>
    </hgroup>
  </header>
  {#if img}
    <img src={img} alt="thumbnail" style:margin-bottom="1em"/>
  {/if}
  <p>{desc}</p>
  {#if url}
    <a href={url} role="button" class="secondary itemlink">Item Website</a>
  {/if}
  {#if showOwner}
    <footer>
    <h5 style:margin-bottom="0">Owned by:</h5>
    {#await contract.methods.ownerOf(tokenId).call() }
      <small aria-busy="true">loading owner...</small>
    {:then owner}
      <figure style:margin-bottom="0">
        <a class="ownerlink" href={"https://etherscan.io/address/" + owner}>{owner}</a>
      </figure>
    {/await}
      </footer>
  {/if}
</article>

<style>
  .itemlink {
    width: 100%;
  }

  .ownerlink {
    white-space: nowrap;
  }
</style>
