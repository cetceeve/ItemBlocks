<script>
  import { Link, navigate } from "svelte-routing";
  import PassportLoader from "./PassportLoader.svelte";
  import PassportCard from "./PassportCard.svelte";

  export let contract;
  export let activeAcc;
</script>

<div class="center">
  <h2>Your digital passport for your physical items</h2>
  <Link to="/create">
    <button><strong>CREATE</strong></button>
  </Link>
  <p>Create a new Item Passport now!</p>
</div>

{#if activeAcc}
  <h4>You created these item passports:</h4>
  {#await contract.methods.getCreatedItemTokens(activeAcc).call() then tokenList}
    {#each tokenList.reverse() as tokenId}
      <PassportLoader {contract} {tokenId} let:data>
        <Link to={"/item/" + tokenId}>
          <div class="notlink">
            <PassportCard {...data} {tokenId} {contract} showOwner/>
          </div>
        </Link>
      </PassportLoader>
    {/each}
  {/await}
{/if}

<style>
  .center {
    text-align: center;
  }
</style>
