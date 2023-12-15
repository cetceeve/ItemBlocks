<script>
  export let name;
  export let desc;
  export let family;
  export let url;
  export let img;
  export let onSubmit;
  export let closeForm;

  let errorMsg = "";

  import { createForm } from "felte";
  import { validator } from "@felte/validator-yup";
  import * as yup from "yup";

  const schema = yup.object({
    name: yup.string().required(),
    desc: yup.string().required(),
    family: yup.string(),
    url: yup.string().url(),
    img: yup.string().url(),
    creator: yup.string(),
  });

  const { form, errors, isSubmitting, interacted } = createForm({
    onSubmit: (values, _) => {
      errorMsg = "";
      // TODO: change this to actually checking if values have changed
      return onSubmit(values);
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
    initialValues: {
      name: name,
      desc: desc,
      family: family,
      url: url,
      img: img,
    },
    extend: validator({ schema }),
  });
</script>

<form use:form>
  <label for="name">Item name</label>
  <input type="text" id="name" name="name" placeholder="Item name" />
  {#if $errors.name}<strong class="errorMsg">{$errors.name}</strong>{/if}

  <label for="desc">Item description</label>
  <input type="text" id="desc" name="desc" placeholder="Item description" />
  {#if $errors.desc}<strong class="errorMsg">{$errors.desc}</strong>{/if}

  <label for="family">Item family</label>
  <input type="text" id="family" name="family" placeholder="Item family" />
  {#if $errors.family}<strong class="errorMsg">{$errors.family}</strong>{/if}

  <label for="url">Link to item website</label>
  <input type="text" id="url" name="url" placeholder="Item url" />
  {#if $errors.url}<strong class="errorMsg">{$errors.url}</strong>{/if}

  <label for="img">Link to item picture</label>
  <input type="text" id="img" name="img" placeholder="Item image" />
  {#if $errors.img}<strong class="errorMsg">{$errors.img}</strong>{/if}

  <button type="submit" aria-busy={$isSubmitting} disabled={$interacted == null}>Save on chain</button>
  {#if errorMsg}<strong class="errorMsg">{errorMsg}</strong>{/if}
</form>

<style>
  .errorMsg {
    color: red;
  }
</style>
