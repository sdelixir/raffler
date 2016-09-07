let raffle = {

  init(socket){
    console.log("raffle init");
    socket.connect()
    let raffleId  = socket.params.raffleId;
    let isAdmin   = socket.params.isAdmin;
    let isEntrant = socket.params.isEntrant;
    this.onReady(raffleId, isAdmin, isEntrant, socket)
  },

  onReady(raffleId, isAdmin, isEntrant, socket){
// SETUP DICE /////////////////////////////////////////////////////////////
    console.log("raffle onReady");
    let die1  = 1;
    let die2  = 2;
    let die3  = 3;

  // isAdmin ////////////////////////////////////////////////////////////////
    // SETUP CHANNEL:TOPIC ////////////////////////////////////////////////////
    if (isAdmin == "true") {
      let raffleChannel = socket.channel("raffle:" + raffleId);
      raffleChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )
    // ADMIN SETS WINNING DICE ///////////////////////////////////////////////
      $("#admin-dice-container").on("click", e => {
        console.log("admin set_winning_dice");
        let payload = {raffleId: raffleId}
        raffleChannel.push("set_winning_dice", payload)
        .receive("error", e => console.log(e) )
      })
      raffleChannel.on("receive_new_dice", resp => {
        console.log("admin receive_new_dice")
        console.log(resp["dice"])

        $("#die1").attr('class', "die show" + resp["dice"][0])
        $("#die2").attr('class', "die show" + resp["dice"][1])
        $("#die3").attr('class', "die show" + resp["dice"][2])

        $("#winning-dice").html(resp["dice"])
      })
    // ADMIN STARTS RAFFLE ///////////////////////////////////////////////////
      $("#start-raffle").on("click", e => {
        console.log("start-raffle")
        raffleChannel.push("start-raffle")
        .receive("error", e => console.log(e) )
      })
      raffleChannel.on("start-raffle", resp => {
        console.log(resp.msg)
        $("#notification").html(resp.msg)
      })
    }

  // isEntrant //////////////////////////////////////////////////////////////
    // SETUP CHANNEL:TOPIC //////////////////////////////////////////////////
    if (isEntrant == "true") {
      // SETUP SHAKE ///////////////////////////////////////////
      var myShakeEvent = new Shake();
      window.addEventListener('shake', shakeRollDice, false);
      myShakeEvent.start({
        threshold: 15, // optional shake strength threshold
        timeout: 1000 // optional, determines the frequency of event generation
      });

      let raffleChannel = socket.channel("raffle:" + raffleId);
      raffleChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )

      let entrantChannel = socket.channel("entrant:" + entrantSlug);
      entrantChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )
    // RAFFLE STARTS
      raffleChannel.on("start-raffle", resp => {
        console.log(resp.msg)
        $("#notification").html(resp.msg)
      })

    // ENTRANT ROLLS DICE
      function shakeRollDice() {
        console.log("entrant request_new_dice");
        let payload = {entrantSlug: entrantSlug}
        entrantChannel.push("request_new_dice", payload)
        .receive("error", e => console.log(e) )
      }



      entrantChannel.on("receive_new_dice", resp => {
        console.log("entrant receive_new_dice")
        console.log(resp["dice"])

        $("#die1").attr('class', "die show" + resp["dice"][0])
        $("#die2").attr('class', "die show" + resp["dice"][1])
        $("#die3").attr('class', "die show" + resp["dice"][2])

        $("#notification").html(resp["dice"])
      })
      raffleChannel.on("raffle over", resp => {
        console.log(resp.msg)
        $("#entrant-dice-container").off();
        $("#notification").html(resp.msg)
      })
      entrantChannel.on("entrant win", resp => {
        console.log(resp.msg)
        $("#entrant-dice-container").off();
        $("#notification").html(resp.msg)
      })
    }
  }
}
export default raffle
