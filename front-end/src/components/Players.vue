<template >
  <div v-if="loading">
    <img class="image" src="../../public/favicon.svg" alt width="120" height="120" />
  </div>
  <div v-else>
    <v-app id="config">
      <v-content>
        <v-card class="mx-auto overflow-hidden">
          <v-app-bar class="headbg">
            <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
            <v-spacer />
            <center>
              <v-toolbar-title class="headfont">
                <strong>Fantasy Football 2022</strong>
              </v-toolbar-title>
            </center>
            <v-spacer />
          </v-app-bar>
        </v-card>

        <v-navigation-drawer v-model="drawer" absolute temporary>
          <v-list nav dense>
            <v-list-item-group active-class="deep-purple--text text--lighten-2">
              <router-link tag="span" to="/">
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-home</v-icon>
                  </v-list-item-icon>
                  <v-list-item-title>Home</v-list-item-title>
                </v-list-item>
              </router-link>
              <router-link tag="span" to="/register">
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-soccer</v-icon>
                  </v-list-item-icon>
                  <v-list-item-title>REGISTER MORE TEAMS</v-list-item-title>
                </v-list-item>
              </router-link>
              <v-list-item @click="end()">
                <v-list-item-icon>
                  <v-icon>mdi-close-circle-outline</v-icon>
                </v-list-item-icon>
                <v-list-item-title>END GAME</v-list-item-title>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-navigation-drawer>
        <v-container absolute fluid>
          <v-row align="center" justify="center">
            <router-link tag="spans" to="/teams">
              <v-btn color="yellow darken-4" class=" signup-button">CURRENT TEAM STATS</v-btn>
            </router-link>
          </v-row>
          <v-row align="center" justify="center">
            <v-col cols="12" md="9">
              <v-card class="elevation-12 " >
                <v-toolbar color="light-blue darken-4">
                  <v-spacer></v-spacer>
                  <v-toolbar-title class="display-1" >The Players</v-toolbar-title>
                  <v-spacer />
                </v-toolbar>
                <v-container>
                  <v-text-field
                    v-model="search"
                    append-icon="mdi-magnify"
                    label="Search"
                    hide-details
                  ></v-text-field>
                  <v-container>
                    <v-data-table
                      :headers="headers"
                      :items="Player"
                      :items-per-page="742"
                      :search="search"
                      hide-default-footer
                      class="elevation-1 style-card"
                    >
                      <template v-slot:item="row">
                        <tr>
                          <td>{{row.item.name}}</td>
                          <td>{{type[row.item.type]}}</td>
                          <td>{{row.item.price}} M</td>
                          <td>
                            <v-btn
                              :disabled="row.item.bidDone"
                              class="mx-2"
                              light
                              small
                              rounded
                              @click="bid(row.item._id)"
                            >BID</v-btn>
                          </td>
                        </tr>
                      </template>
                    </v-data-table>
                  </v-container>
                </v-container>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-content>
      <Footer />
    </v-app>
  </div>
</template>

<script>
import axios from "axios";
import Footer from "./layout/Footer";

export default {
  name: "Player",
  components: {
    Footer
  },
  data() {
    return {
      search: "",
      drawer: false,
      loading: true,

      headers: [
        {
          text: "Name",
          align: "start",
          sortable: false,
          value: "name"
        },
        { text: "Player Type", align: "start", sortable: false, value: "type" },
        { text: "Price", sortable: false, value: "price" },
        { text: "Bid", sortable: false, value: "_id" }
      ],
      Player: [],
      type: ["", "Goalkeeper","Defender", "Mid-Fielder",  "Forward"]
    };
  },
  methods: {
    end() {
      alert("if you clicked this by mistake, close this tab NOW");
      axios.post("http://localhost:3000/end").then(() => {
        this.$router.push("/result");
      });
    },
    bid(a) {
      var b = { id: a };
      axios.post("http://localhost:3000/beginBid", b);
      this.$router.push({ name: "Player", query: b });
    }
  },
  created() {
    axios.get("http://localhost:3000/getStatus").then(res => {
      var a = res.data;
      if (a.hasStarted === true) {
        if (a.lastPlayer.length > 0) {
          if (a.bidDone === true) this.$router.push("/players");
          else {
            var b = { id: a.lastPlayer };
            axios.post("http://localhost:3000/getPlayer", b).then(response => {
              if (response.data.bidDone === false)
                this.$router.push({
                  name: "Player",
                  query: { id: a.lastPlayer }
                });
            });
          }
        } else {
          this.$router.push("/players");
        }
      }
    });
  },
  created() {
    this.$vuetify.theme.dark = true;
    axios
      .get("http://localhost:3000/getList")
      .then(response => {
        this.Player = response.data;
        this.loading = false;
      })
      .catch(error => {
        location.reload();
        console.log(error);
      });
  }
};
</script>

<style>
.image {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 120px;
  height: 120px;
  margin: -60px 0 0 -60px;
  webkit-animation: spin 4s linear infinite;
  -moz-animation: spin 4s linear infi-nite;
  animation: spin 4s linear infinite;
}
.style-card{
  backdrop-filter: blur(8px);
	background: rgba(70, 68, 68, 0.561) !important;
}
.signup-button {
	background-color: rgb(14, 38, 88);
	border: 1px solid rgb(8, 16, 44);
	border-radius: 8rem;
  font-size: 1.9rem;
  padding: 3rem 2rem;
  margin: 0.8rem;
	color: #eee;
	/* 
	overflow: hidden;
	
	position: relative;
	transition: all 0.2s ease-in-out;
	z-index: 10; */
}

@import url("http://fonts.cdnfonts.com/css/pf-tempesta-seven");
@import url('https://fonts.googleapis.com/css2?family=Questrial&family=Roboto:wght@100&display=swap');
.headfont{
   font-family: "PF Tempesta Seven", sans-serif;
	font-family: "PF Tempesta Seven Extended", sans-serif;
	font-family: "PF Tempesta Seven Condensed", sans-serif;
	font-family: "PF Tempesta Seven Compressed", sans-serif; 
}
.headbg{
  background: rgba(177, 226, 87, 0.685) !important;
  backdrop-filter: blur(5px);

}
@-moz-keyframes spin {
  100% {
    -moz-transform: rotate(360deg);
  }
}
@-webkit-keyframes spin {
  100% {
    -webkit-transform: rotate(360deg);
  }
}
@keyframes spin {
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
</style>