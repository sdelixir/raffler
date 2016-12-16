import MainView from '../main';
import socket from "../../socket"

export default class View extends MainView {
  mount() {
    super.mount();

    // Specific logic here
    console.log('EntrantShowView mounted');
    console.log("raffle onReady");

  // SETUP CHANNEL:TOPIC //////////////////////////////////////////////////
    socket.connect()
    let raffleId  = socket.params.raffleId;

    let raffleChannel = socket.channel("raffle:" + raffleId);
    raffleChannel.join()
      .receive("ok", resp => console.log("resp: " + resp) )
      .receive("error", reason => console.log("join failed", reason) )

    let entrantChannel = socket.channel("entrant:" + entrantSlug);
    entrantChannel.join()
    .receive("ok", resp => console.log("resp: " + resp) )
    .receive("error", reason => console.log("join failed", reason) )

  // RAFFLE STARTS
    raffleChannel.on("countdown", resp => {
      console.log(resp.msg)
      $("#notification").show();
      $("#notification").html(resp.msg)
    })
    raffleChannel.on("start-raffle", resp => {
      console.log(resp.msg)
      // SETUP SHAKE ///////////////////////////////////////////
      var myShakeEvent = new Shake();
      window.addEventListener('shake', shakeRollDice, false);
      window.addEventListener('click', shakeRollDice, false);
      myShakeEvent.start({
        threshold: 15, // optional shake strength threshold
        timeout: 1000 // optional, determines the frequency of event generation
      });
      $("#notification").hide();
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
    })
    raffleChannel.on("raffle over", resp => {
      console.log(resp.msg)
      $("#entrant-dice-container").off();
      $("#entrant-dice-container").stop();
      $("#entrant-dice-container").hide();

      window.removeEventListener('shake', shakeRollDice, false);
      window.removeEventListener('click', shakeRollDice, false);

      $("#notification").show();
      $("#notification").html(resp.msg)
    })
    entrantChannel.on("entrant win", resp => {
      console.log(resp.msg)
      $("#entrant-dice-container").off();
      $("#entrant-dice-container").stop();
      $("#entrant-dice-container").hide();

      window.removeEventListener('shake', shakeRollDice, false);
      window.removeEventListener('click', shakeRollDice, false);

      $("#notification").show();
      $("#notification").html(resp.msg)
    })
  }

  unmount() {
    super.unmount();

    // Specific logic here
    console.log('EntrantShowView unmounted');
  }
}
