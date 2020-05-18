<template>
  <header class="py-4 mb-5">
    <div class="container d-flex flex-wrap align-items-center justify-content-around">
      <div class="flex-1 d-flex align-items-center mr-5">
        <a href="/" class="pl-4 text-decoration-none text-primary">Nextie</a>
      </div>
      <div>
        <router-link to="/" class="text-muted px-2 text-decoration-none" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="text-muted px-2 text-decoration-none" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/home" class="text-muted px-2 text-decoration-none" v-if="signedIn()">Home</router-link>
        <a href="#" @click.prevent="signOut" class="text-muted px-2 text-decoration-none" v-if="signedIn()">Sign out</a>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
