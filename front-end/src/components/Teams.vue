<template>
  <div v-if="loading">
    <img class="image" src="../../public/favicon.svg" alt width="120" height="120" />
  </div>
  <div v-else>
    <v-app id="teams">
      <span class="bg"></span>
      <v-content>
        <v-card class="mx-auto overflow-hidden">
          <v-app-bar class="headbg" >
            <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
            <v-spacer />
            <center>
              <v-toolbar-title >

                <strong>TEAM DETAILS</strong>
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
            </v-list-item-group>
          </v-list>
        </v-navigation-drawer>

        <v-container fluid>
          <v-row align="center" justify="center">
            <router-link tag="span" to="/players">
              <v-btn color="red darken-4" rounded>Back to Auction</v-btn>
            </router-link>
          </v-row>
          <v-data-iterator :items="Teams" hide-default-footer>
            <template v-slot:default="props">
              <v-row>
                <v-col v-for=" team in props.items" :key="team.name" cols="12" sm="6" lg="3">
                  <v-card class=" elevation-12 style-card" max-height="340" color="#2196F3">
                    <v-card-title class="subheading font-weight-bold pa-2">{{ team.name }}</v-card-title>
                    <v-list dense>
                      <v-list-item>
                        <v-list-item-content>MONEY LEFT:</v-list-item-content>
                        <v-list-item-content class="align-end">{{ team.money }}</v-list-item-content>
                      </v-list-item>
                      <v-list-item>
                        <v-list-item-content>TOTAL PLAYERS:</v-list-item-content>
                        <v-list-item-content class="align-end">{{ team.number.total}}</v-list-item-content>
                      </v-list-item>
                      <v-list-item>
                        <v-list-item-content>GOALKEEPER :</v-list-item-content>
                        <v-list-item-content class="align-end">{{ team.number.gk}}</v-list-item-content>
                      </v-list-item>
                      <v-list-item>
                        <v-list-item-content>FORWARD :</v-list-item-content>
                        <v-list-item-content class="align-end">{{ team.number.fwd}}</v-list-item-content>
                      </v-list-item>
                      <v-list-item>
                        <v-list-item-content>DEFENDER :</v-list-item-content>
                        <v-list-item-content class="align-end">{{ team.number.df}}</v-list-item-content>
                      </v-list-item>
                      <v-list-item>
                        <v-list-item-content>MIDFIELDER:</v-list-item-content>
                        <v-list-item-content class="align-end">{{ team.number.mf}}</v-list-item-content>
                      </v-list-item>
                      <v-list-item>
                        <v-list-item-content>                        
                            <div class="text-center">
                        <v-dialog
                          v-model="dialog"
                          width="500"
                        >
                          <template v-slot:activator="{ on, attrs }">
                            <v-btn
                              color="red lighten-2"
                              dark
                              v-bind="attrs"
                              v-on="on"
                            >
                              Show Team
                            </v-btn>
                          </template>

                          <v-card>
                            <v-card-title class="text-h5 black lighten-2">
                              Team List
                            </v-card-title>
                            <v-list>
                               <v-list-item v-for="player in team.players">
                                <v-list-item-content>
                                  <v-list-item-subtitle >{{ player}}</v-list-item-subtitle>
                                </v-list-item-content>
                              </v-list-item>
                            </v-list>

                          
                          </v-card>
                        </v-dialog>
                      </div>
                      </v-list-item-content>
                      </v-list-item>
                    </v-list>
                  </v-card>
                </v-col>
              </v-row>
            </template>
          </v-data-iterator>
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
  name: "Teams",
  components: {
    Footer
  },
  methods: {
    sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }
  },
  data() {
    return {
      drawer: false,
      type: ["", "Goalkeeper","Defender", "Mid-Fielder",  "Forward"],
      Teams: [],
      money: "",
      loading: false
    };
  },
  mounted() {
    this.loading = true;
    (this.$vuetify.theme.dark = true),
      axios
        .get("http://localhost:3000/getTeamstats")
        .then(response => {
          this.Teams = response.data;
        })
        .catch(error => {
          console.log(error);
        })
        .finally(() =>
          this.sleep(500).then(() => {
            this.loading = false;
          })
        );
  }
};
</script>

<style scoped>
.bg {
  width: 100%;
  height: 90%;
  position: absolute;
  top: 0;
  left: 0;
  opacity: 0.8;
  background: url("../../img/iconic.jpeg") no-repeat;
  background-size: cover;
  background-color: blue;
  transform: scale(1.1);
}
#inspire {
  height: 100%;
  width: 100%;
  overflow: auto;
  padding-right: 20px;
}
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
.style-card{
  backdrop-filter: blur(8px);
	background: rgba(70, 68, 68, 0.8) !important;
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
