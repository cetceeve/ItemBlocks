<script>
    import { Link } from "svelte-routing";
</script>

<div class="center">
    <h2>Your digital passport for your physical items</h2>
    <button><strong>CREATE</strong></button>
    <p>Create a new Item Passport now!</p>
</div>
<Link to="/item/1">
    <button class="outline">
        Go to Test Item
    </button>
</Link>

<style>
.center {
    text-align: center;
}
</style>