# hubot azure power down
# Commands:
#   hubot paperspace down - power down paperspace vms
#   hubot paperspace up - power up paperspace vms
#   hubot stream start - start obs and stream last profile
#   hubot stream stop - kill obs and stream

vms = [ 'psom35f1h', 'psv6mebry' ]
ips = [ '184.105.175.33', '184.105.174.7' ]

apikey = process.env.HUBOT_PAPERSPACE_API_KEY
module.exports = (robot) ->
  robot.respond /paperspace down/i, (msg) ->
    for vm in vms
      @exec = require('child_process').exec
      command = "paperspace machines stop --machineId #{vm}  --apiKey #{apikey}"
      msg.send "Vm powering down #{vm}"

      @exec command

  robot.respond /paperspace up/i, (msg) ->
    for vm in vms
      @exec = require('child_process').exec
      command = "paperspace machines start --machineId #{vm} --apiKey #{apikey}"
      # your code here, knowing it was successful
      msg.send "Vm powering up #{vm}"

      @exec command

  robot.respond /stream start/i, (msg) ->
    for ip in ips
      url = "http://#{ip}:5000/s3cr3tStr3mUrl"
      msg.http("#{url}")
        .get() (err, res, body) ->
          if err
            res.send "Encountered an error :( #{err}"
            return
          res.send "responce body #{body} " 
        # your code here, knowing it was successful
      msg.send "#{url}"
    msg.send "Stream starting"

  robot.respond /stream stop/i, (msg) ->
    for ip in ips
      url = "http://#{ip}:5000/s3cr3tStr3mk1ll"
      msg.http("#{url}")
        .get() (err, res, body) ->
          if err
            res.send "Encountered an error :( #{err}"
            return
        # your code here, knowing it was successful
      msg.send "#{url}"
    msg.send "Stream stopped"

  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/test/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    details = data.context.details

    robot.messageRoom room, "Rancher Slave: #{details}"

    res.send 'OK'
