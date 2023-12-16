<script>
  import svelteLogo from "./assets/svelte.svg";
  import viteLogo from "/vite.svg";
  import { Router, Link, Route } from "svelte-routing";
  import "@picocss/pico";
  // This function detects most providers injected at window.ethereum.
  import detectEthereumProvider from "@metamask/detect-provider";
  import Passport from "./lib/Passport.svelte";
  import Home from "./lib/Home.svelte";
  import { writable } from "svelte/store";
  import Create from "./lib/Create.svelte";
  import { Web3 } from "web3";
  import ABI from "./assets/ABI.json";
    import History from "./lib/History.svelte";

  const activeAcc = writable("");

  const web3 = new Web3(window.ethereum);
  const contract = new web3.eth.Contract(
    ABI,
    "0x5f0B6625541d613ea33098d2afdE2aE466dbF1ec",
  );

  async function connect() {
    if (!window.ethereum) {
      alert("Please install MetaMask!");
      return;
    }

    // From now on, this should always be true:
    // provider === window.ethereum
    try {
      let accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
        params: [],
      });

      console.log(accounts);
      $activeAcc = accounts[0];

      // add listener for account changes
      window.ethereum.on("accountsChanged", (accounts) => {
        if (accounts.length > 0) {
          $activeAcc = accounts[0];
        } else {
          $activeAcc = "";
        }
      });
    } catch (err) {
      console.log(err);
    }
  }
</script>

<Router>
  <header>
    <nav>
      <ul>
        <li>
          <Link to="/">
            <strong>ItemBlocks</strong>
          </Link>
        </li>
      </ul>

      <ul>
        <li>
          {#await detectEthereumProvider()}
            <button class="secondary outline" disabled>Connect</button>
          {:then provider}
            {#if provider == null}
              <a href="https://metamask.io" role="button" class="primary"
                >Install Metamask</a
              >
            {:else if $activeAcc.length > 0}
              <input
                id="activeAccount"
                type="text"
                value={$activeAcc}
                aria-invalid="false"
                readonly
              />
            {:else}
              <button class="primary" on:click={connect}>Connect</button>
            {/if}
          {/await}
        </li>
      </ul>
    </nav>
  </header>

  <main class="container">
    <Route path="/">
      <Home {contract} activeAcc={$activeAcc}/>
    </Route>
    <Route path="/item/:tokenId" let:params>
      <Passport tokenId={params.tokenId} activeAcc={$activeAcc} {contract}/>
    </Route>
    <Route path="/history/:tokenId" let:params>
      <History tokenId={params.tokenId} activeAcc={$activeAcc} {contract}/>
    </Route>
    <Route path="/create">
      <Create activeAcc={$activeAcc} {contract}/>
    </Route>
  </main>
</Router>

<style>
  header {
    padding-left: 1em;
    padding-right: 1em;
    margin-bottom: 1em;
  }

  #activeAccount {
    max-width: 8em;
  }
</style>
