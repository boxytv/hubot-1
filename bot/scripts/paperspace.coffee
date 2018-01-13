# hubot azure power down
# Commands:
#   hubot paperspace down - power down paperspace vms
#   hubot paperspace up - power up paperspace vms

vms = [ "psom35f1h", "psv6mebry" ]

apikey = process.env.HUBOT_PAPERSPACE_API_KEY
module.exports = (robot) ->
  robot.respond /paperspace down/i, (msg) ->
    for vm in vms
      @exec = require('child_process').exec
      command = "paperspace machines stop --machineId 'psom35f1h' --apiKey #{apikey}"
      # your code here, knowing it was successful
      msg.send "Powering down paperspace"

      @exec command, (error, stdout, stderr) ->
        msg.send error
        msg.send stdout
        msg.send stderr

  robot.respond /paperspace up/i, (msg) ->
    for vm in vms
      @exec = require('child_process').exec
      command = "paperspace machines start --machineId 'psom35f1h' --apiKey #{apikey}"
      # your code here, knowing it was successful
      msg.send "Powering up paperspace"

      @exec command, (error, stdout, stderr) ->
        msg.send error
        msg.send stdout
        msg.send stderr

  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/test/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    details = data.context.details

    robot.messageRoom room, "Rancher Slave: #{details}"

    res.send 'OK'
