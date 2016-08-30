let Raffle = {

  init(socket){
    console.log("init");
    socket.connect()
    let entrantSlug = socket.params.entrantSlug;
    let raffleId    = socket.params.raffleId;
    this.onReady(raffleId, entrantSlug, socket)
  },

  onReady(raffleId, entrantSlug, socket){
    console.log("onReady");
    let die1  = 1;
    let die2  = 2;
    let die3  = 3;

    let raffleChannel  = socket.channel("raffle:" + raffleId);
    let entrantChannel = socket.channel("entrant:" + entrantSlug);

    window.addEventListener("click", e => {
      let payload = {entrantSlug: entrantSlug}
      entrantChannel.push("request_new_dice", payload)
                   .receive("error", e => console.log(e) )
    })

    entrantChannel.on("receive_new_dice", resp => {
      console.log("receive_new_dice")
      console.log(resp["dice"])
      $("#die1").attr('class', "die show" + resp["dice"][0])
      $("#die2").attr('class', "die show" + resp["dice"][1])
      $("#die3").attr('class', "die show" + resp["dice"][2])
    })

    raffleChannel.on("raffle_channel test", resp => {
      console.log(resp["body"])
    })

    raffleChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )
    entrantChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )
  }

}
export default Raffle
