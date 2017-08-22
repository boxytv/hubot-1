# hubot azure power down
# Commands:
#   hubot dev down - power down azure vms
#   hubot dev up - power up azure vms

module.exports = (robot) ->
  robot.respond /dev down/i, (msg) ->
    msg.http("https://s5events.azure-automation.net/webhooks?token=kM62chx%2fEo1w%2f0QtLLLN6ZVA2zFeVuad3sQ11XdbW54%3d
")
      .post() (err, res, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
      # your code here, knowing it was successful
        msg.send "Powering down dev"

  robot.respond /dev up/i, (msg) ->
    msg.http("https://s5events.azure-automation.net/webhooks?token=9L6S7qbG1acB7pAf5hmuW3%2frHuhoaVMeksjq%2fsZVTwc%3d
")
      .post() (err, res, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
      # your code here, knowing it was successful
        msg.send "Powering up dev"

  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/test/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    details = data.context.details

    robot.messageRoom room, "Rancher Slave: #{details}"

    res.send 'OK'
