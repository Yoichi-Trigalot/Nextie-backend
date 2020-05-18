<template>
    <div class="div">
        <div class="w-50 mx-auto py-5" v-if='admin == currentUser'>
            <div>
              <h1>On demand Unicorns</h1>
                <ul class="list-unstyled mt-4">
                  <li class="py-4 border rounded mb-2 p-2" v-for="demand in demands" :key="demand" :demand="demand">
                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                      <div class="flex-grow-1 d-flex justify-content-around align-items-center pr-4">
                        <div class="w-100">
                          <p class="m-0">User : <span class='font-weight-bolder'>{{ demand.email }}</span></p>
                        </div>
                        <div class="w-100">
                          <button class="bg-transparent text-success tex-decoration-none font-weight-bold py-2 px-4 rounded border border-success"
                          @click.prevent="addUnicorn(demand.id)">Create unicorn</button>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
            </div>
            <div>
              <h1>List of unicorns </h1>
              <ul class="list-unstyled mt-4">
                <li class="py-4 border rounded mb-2 p-2" v-for="unicorn in unicorns" :key="unicorn.id" :unicorn="unicorn">
                  <div class="d-flex align-items-center justify-content-between flex-wrap">
                    <div class="flex-grow-1 d-flex flex-column justify-content-around align-items-center flex-wrap pr-4">
                      <h5 class="mb-4 font-weight-bold">{{ getUser(unicorn) }}'s Unicorn : </h5>
                      <div class="w-100 d-flex justify-content-around">
                        <p class="m-0">Sex : <span class='font-weight-bolder'>{{ unicorn.sex }}</span></p>
                        <p class="m-0">Type : <span class='font-weight-bolder'>{{ unicorn.unicorn_type }}</span></p>
                        <p class="m-0">Color : <span class='font-weight-bolder'>{{ unicorn.color }}</span></p>
                      </div>

                    </div>
                    <div class="d-flex align-items-center">
                      <button class="bg-transparent text-primary border border-primary tex-decoration-none font-weight-bold py-2 px-4 mr-2 rounded"
                      @click.prevent="editUnicorn(unicorn)">Edit</button>

                      <button class="bg-transparent text-danger tex-decoration-none font-weight-bold py-2 px-4 rounded border border-danger"
                      @click.prevent="removeUnicorn(unicorn)">Delete</button>
                    </div>
                  </div>
                  <div v-if="unicorn == editedUnicorn">
                    <form action="" @submit.prevent="updateUnicorn(unicorn)">
                      <div class="mb-5 p-4 bg-white rounded border border-light mt-4">

                        <div class="mb-5 form-group">
                          <label class="label">Sex</label>
                          <input class="form-control" v-model="unicorn.sex" />
                        </div>

                        <div class="mb-5 form-group">
                          <label class="label">Type</label>
                          <input class="form-control" v-model="unicorn.unicorn_type" />
                        </div>

                        <div class="mb-5 form-group">
                          <label class="label">Color</label>
                          <input class="form-control" v-model="unicorn.color" />
                        </div>

                        <input type="submit" value="Update" class="bg-transparent text-primary border border-primary text-decoration-none font-weight-bold py-2 px-4 mr-2 rounded">
                      </div>
                    </form>
                  </div>
                </li>
              </ul>
            </div>
        </div>
        <div class="w-50 mx-auto py-5" v-else>
          <div class="div" v-if='unicorn.sex == ""'>
            <h1>Don't have a unicorn Yet ? Hask for one !</h1>
            <button class="bg-transparent text-alert tex-decoration-none font-weight-bold py-2 px-4 rounded border border-alert"
            @click.prevent="removeUnicorn(unicorn)">Ask for a unicorn</button>
          </div>
          <div class="div" v-else>
            <h1 class="mb-5">Your Unicorn : </h1>
            <div class="w-100 d-flex justify-content-around">
              <p class="m-0">Sex : <span class='font-weight-bolder'>{{ unicorn.sex }}</span></p>
              <p class="m-0">Type : <span class='font-weight-bolder'>{{ unicorn.unicorn_type }}</span></p>
              <p class="m-0">Color : <span class='font-weight-bolder'>{{ unicorn.color }}</span></p>
              <button class="bg-transparent font-weight-lighter text-primary border border-primary tex-decoration-none font-weight-bold py-1 px-2 mr-2 rounded"
              @click.prevent="editUnicorn(unicorn)">Edit color</button>
            </div>
          </div>
        </div>
    </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      unicorns: [],
      unicorn: [],
      users: [],
      admin: 'true',
      userId: '',
      currentUser: '',
      demands: [],
      newUnicorn: [],
      error: '',
      editedUnicorn: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/unicorns')
        .then(response => { this.unicorns = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/users')
        .then(response => { this.users = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/demands')
        .then(response => { this.demands = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/currentuser')
        .then(response => {
          this.currentUser = response.data.admin
          this.user_id = response.data.id
        })
        .catch(error => this.setError(error, 'Cannot find current User'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    getUser (unicorn) {
      const userDatas = this.users.filter(user => user.id === unicorn.user_id)
      const user = userDatas[0].email
      return user
    },
    getUnicornByUserId (id) {
      const userId = this.userId
      const unicorn = this.unicorns.filter(uicorn => unicorn.user_id === userId)
      this.unicorn = unicorn
    },
    removeUnicorn (unicorn) {
      this.$http.secured.delete(`/api/v1/unicorns/${unicorn.id}`)
        .then(response => {
          this.records.splice(this.unicorns.indexOf(unicorn), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete unicorn'))
    },
    addUnicorn (user) {
      this.$http.secured.post('/api/v1/unicorns/', { unicorn: { sex: 'default', unicorn_type: 'default', color: 'default', user_id: user } })
        .then(response => {
          this.unicorns.push(response.data)
        })
        .catch(error => this.setError(error, 'Cannot create Unicorn'))
    },
    editUnicorn (unicorn) {
      this.editedUnicorn = unicorn
    },
    updateUnicorn (unicorn) {
      this.editedUnicorn = ''
      this.$http.secured.patch(`/api/v1/unicorns/${unicorn.id}`, { unicorn: { sex: unicorn.sex, color: unicorn.color, unicorn_type: unicorn.unicorn_type } })
        .catch(error => this.setError(error, 'Cannot update unicorn'))
    }
  }
}
</script>
