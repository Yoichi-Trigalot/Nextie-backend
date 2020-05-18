<template>
    <div class="div">
        <div class="container">
            <div v-if='isadmin'>
                <h1>Welcome new user in nextie</h1>

            </div>
        </div>
    </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      msg: 'Welcome your login'
    }
  }
}
</script>
