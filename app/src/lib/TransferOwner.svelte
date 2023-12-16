<script>
  import { createForm } from "felte";

  export let contract;
  export let closeForm;
  export let activeAcc;
  export let tokenId;
  let errorMsg = "";

  async function transferOwnership(input) {
    // we are deliberatly not doing any error handling here as it will be done in the form component
    if (!activeAcc) {
      throw "Please connect to a wallet!";
    }
    return await contract.methods.updateOwnership(
      activeAcc, input.owner, tokenId
    ).send({from: activeAcc});
  }

  const { form, isSubmitting } = createForm({
    onSubmit: (values, _) => {
      console.log(values)
      errorMsg = "";
      // TODO: change this to actually checking if values have changed
      return transferOwnership(values);
    },
    onSuccess(response, context) {
      // Do something with the returned value from `onSubmit`.
      console.log(response);
      console.log("on success was called");
      closeForm();
    },
    onError(err, context) {
      // Do something with the error thrown from `onSubmit`.
      errorMsg = err;
    },
  });
</script>

<form use:form>
  <label for="owner">Item name</label>
  <input type="text" id="owner" name="owner" placeholder="Next owner" />

  <button type="submit" aria-busy={$isSubmitting}>Transfer Ownership</button>
  {#if errorMsg}<strong class="errorMsg">{errorMsg}</strong>{/if}
</form>

<style>
  .errorMsg {
    color: red;
  }
</style>
