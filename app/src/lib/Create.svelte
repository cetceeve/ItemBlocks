<script>
    export let activeAcc;
    import PassportForm from './PassportForm.svelte';
</script>

<article>
    <header>Create a new item passport</header>
    <PassportForm
        name="nametest"
        desc=""
        family=""
        url=""
        img=""
        onSubmit={(values, context) => {console.log(values)}}/>

</article>