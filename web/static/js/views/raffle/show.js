import MainView from '../main';
import socket from "../../socket"

export default class View extends MainView {
  mount() {
    super.mount();

    // Specific logic here
    console.log('RaffleShowView mounted');
    socket.connect()

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

  unmount() {
    super.unmount();

    // Specific logic here
    console.log('RaffleShowView unmounted');
  }
}
