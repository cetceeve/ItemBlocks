<script>
  export let name;
  export let desc;
  export let family;
  export let url;
  export let img;
</script>

<article>
  <header>
    <strong>{name}</strong>
  </header>
  {#if img}
    <img src={img} alt="thumbnail" />
  {/if}
  <p>{desc}</p>
  {#if url}
    <a href={url} role="button" class="secondary itemlink">Item Website</a>
  {/if}
  {#if family}
    <footer>{family}</footer>
  {/if}
</article>

<style>
  .itemlink {
    width: 100%;
  }
</style>
