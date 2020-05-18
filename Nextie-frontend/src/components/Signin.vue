<template>
    <div class="container d-flex justify-content-center align-items-center">
        <div class="border-sm rounded shadow p-5 text-center">
            <h3 class='text-muted mb-5'>Sign in</h3>
            <form @submit.prevent='signin'>
                <div class="text-danger" v-if="error">{{ error }}</div>

                <div class="mb-3 form-group text-left">
                    <label for="email">E-mail address</label>
                    <input class='form-control' type="email" v-model="email" id="email">
                </div>
                <div class="mb-3 form-group text-left">
                    <label for="password">Password</label>
                    <input class='form-control' type="password" v-model="password" id="password">
                </div>
                <button type="submit" class='text-decoration-none font-weight-bolder bg-success rounded d-inline w-100 p-2 mb-3'>Sign In</button>
                <div class="mb-3">
                    <router-link to="/signup">Sign Up</router-link>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/home')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/home')
      }
    }
  }
}
</script>
