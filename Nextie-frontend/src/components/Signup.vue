<template>
    <div class="container d-flex justify-content-center align-items-center">
        <div class="border-sm rounded shadow p-5 text-center">
            <h3 class='text-muted mb-5'>Sign up</h3>
            <form @submit.prevent='signup'>
                <div class="text-danger" v-if="error">{{ error }}</div>

                <div class="mb-3 form-group text-left">
                    <label for="email">E-mail address</label>
                    <input class='form-control' type="email" v-model="email" id="email">
                </div>
                <div class="mb-3 form-group text-left">
                    <label for="password">Password</label>
                    <input class='form-control' type="password" v-model="password" id="password">
                </div>
                <div class="mb-3 form-group text-left">
                    <label for="password_confirmation">Password confirmation</label>
                    <input class='form-control' type="password" v-model="password_confirmation" id="password_confirmation">
                </div>
                <button type="submit" class='text-decoration-none font-weight-bolder bg-success rounded d-inline w-100 p-2 mb-3'>Sign Up</button>
                <div class="mb-3">
                    <router-link to="/">Sign in</router-link>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/home')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/home')
      }
    }
  }
}
</script>
