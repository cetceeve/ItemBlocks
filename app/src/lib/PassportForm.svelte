<script>
    export let name;
    export let desc;
    export let family;
    export let url;
    export let img;
    export let onSubmit;

    import { createForm } from 'felte';
    import { validator } from '@felte/validator-yup';
    import * as yup from 'yup';

    const schema = yup.object({
        name: yup.string().email().required(),
        desc: yup.string().required(),
        family: yup.string(),
        url: yup.string().url(),
        img: yup.string().url(),
        creator: yup.string(),
    });
  
    const { form } = createForm({
      onSubmit: onSubmit,
      onSuccess(response, context) {
        // Do something with the returned value from `onSubmit`.
      },
      onError(err, context) {
        // Do something with the error thrown from `onSubmit`.
      },
      initialValues: {
        name: name,
        desc: desc,
        family: family,
        url: url,
        img: img,
      }
    })
  </script>
  
  <form use:form>
    <label for="name">Item name</label>
    <input type="text" id="name" name="name" placeholder="Item name">
    <!-- <small>We'll never share your email with anyone else.</small> -->

    <label for="desc">Item description</label>
    <input type="text" id="desc" name="desc" placeholder="Item description">

    <label for="family">Item family</label>
    <input type="text" id="family" name="family" placeholder="Item family">

    <label for="url">Link to item website</label>
    <input type="text" id="url" name="url" placeholder="Item url">

    <label for="img">Link to item picture</label>
    <input type="text" id="img" name="img" placeholder="Item image">

    <button type="submit">Save on chain</button>
  </form>