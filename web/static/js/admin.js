let Admin = {

  init(socket){
    console.log("admin init");
    socket.connect()
    let raffleId    = socket.params.raffleId;
    this.onReady(raffleId, socket)
  },

  onReady(raffleId, socket){
    console.log("admin onReady");
    let die1  = 1;
    let die2  = 2;
    let die3  = 3;

    let raffleChannel  = socket.channel("raffle:" + raffleId);

    $("#start-raffle").on("click", e => {
      console.log("start-raffle")
      raffleChannel.push("start-raffle")
      .receive("error", e => console.log(e) )
    })

    $("#dice-container").on("click", e => {
      console.log("click");
      let payload = {raffleId: raffleId}
      raffleChannel.push("set_winning_dice", payload)
                   .receive("error", e => console.log(e) )
      raffleChannel.push("html_test", payload)
                   .receive("error", e => console.log(e) )
    })

    raffleChannel.on("receive_new_dice", resp => {
      console.log("admin receive_new_dice")
      console.log(resp["dice"])

      $("#die1").attr('class', "die show" + resp["dice"][0])
      $("#die2").attr('class', "die show" + resp["dice"][1])
      $("#die3").attr('class', "die show" + resp["dice"][2])
    })

    raffleChannel.on("start-raffle", resp => {
      console.log(resp.msg)
      $("#notification").html(resp.msg)
    })
    
    raffleChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )
  }

}
export default Admin
