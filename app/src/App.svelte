<script>
  import svelteLogo from './assets/svelte.svg'
  import viteLogo from '/vite.svg'
  import { Router, Link, Route } from "svelte-routing";
  import "@picocss/pico";
  // This function detects most providers injected at window.ethereum.
  import detectEthereumProvider from '@metamask/detect-provider';
  import Passport from './lib/Passport.svelte'
  import Home from './lib/Home.svelte';
  import { writable } from 'svelte/store';

  const activeAcc = writable("");

  async function connect() {
    if (!window.ethereum) {
      alert('Please install MetaMask!');
      return;
    }

    // From now on, this should always be true:
    // provider === window.ethereum
    try {
      let accounts = await window.ethereum
        .request({
            method: 'eth_requestAccounts',
            params: [],
        })
        
        console.log(accounts)
        $activeAcc = accounts[0]

        // add listener for account changes
        window.ethereum.on('accountsChanged', (accounts) => {
          if (accounts.length > 0) {
            $activeAcc = accounts[0];
          } else {
            $activeAcc = "";
          }
        });
    } catch(err) {
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
              <a href="https://metamask.io" role="button" class="primary">Install Metamask</a>
            {:else}
              {#if $activeAcc.length > 0}
                <input id="activeAccount" type="text" value={$activeAcc}  aria-invalid="false" readonly>
              {:else}
                <button class="primary" on:click={connect}>Connect</button>
              {/if}
            {/if}
          {/await}
        </li>
      </ul>
    </nav>
  </header>
  
  <main class="container">
    <Route path="/">
      <Home />
    </Route>    
    <Route path="/item/:id" let:params>
      <Passport id={params.id} activeAcc={$activeAcc}/>
    </Route>
  </main>
</Router>

<style>
header {
  background-color: #18232c;
  padding-left: 1em;
  padding-right: 1em;
  margin-bottom: 1em;
}

#activeAccount {
  max-width: 8em;
}

/* Deep-purple Light scheme (Default) */
/* Can be forced with data-theme="light" */
[data-theme="light"],
:root:not([data-theme="dark"]) {
  --primary: #5e35b1;
  --primary-hover: #512da8;
  --primary-focus: rgba(94, 53, 177, 0.125);
  --primary-inverse: #FFF;
}

/* Deep-purple Dark scheme (Auto) */
/* Automatically enabled if user has Dark mode enabled */
@media only screen and (prefers-color-scheme: dark) {
  :root:not([data-theme]) {
    --primary: #5e35b1;
    --primary-hover: #673ab7;
    --primary-focus: rgba(94, 53, 177, 0.25);
    --primary-inverse: #FFF;
  }
}

/* Deep-purple Dark scheme (Forced) */
/* Enabled if forced with data-theme="dark" */
[data-theme="dark"] {
  --primary: #5e35b1;
  --primary-hover: #673ab7;
  --primary-focus: rgba(94, 53, 177, 0.25);
  --primary-inverse: #FFF;
}

/* Deep-purple (Common styles) */
:root {
  --form-element-active-border-color: var(--primary);
  --form-element-focus-color: var(--primary-focus);
  --switch-color: var(--primary-inverse);
  --switch-checked-background-color: var(--primary);
}
</style>
