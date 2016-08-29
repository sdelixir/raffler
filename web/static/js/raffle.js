let Raffle = {

  init(socket){
    console.log("init");
    socket.connect()
    let entrantId = "lobby";
    this.onReady(entrantId, socket)
  },

  onReady(entrantId, socket){
    console.log("onReady");
    let die1  = 1;
    let die2  = 2;
    let die3  = 3;

    let raffleChannel = socket.channel("raffle:lobby");

    window.addEventListener("click", e => {
      let payload = {entrantId: entrantId}
      raffleChannel.push("request_new_dice", payload)
                   .receive("error", e => console.log(e) )
    })
    raffleChannel.on("receive_new_dice", resp => {
      console.log(resp["dice"])
      $("#die1").attr('class', "die show" + resp["dice"][0])
      $("#die2").attr('class', "die show" + resp["dice"][1])
      $("#die3").attr('class', "die show" + resp["dice"][2])
    })

    raffleChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )
  }

}
export default Raffle
