MilkCocoa = require 'milkcocoa'
milkCocoa = new MilkCocoa("seaicr6iewv.mlkcca.com")
dataStore = milkCocoa.dataStore('incrimenter')

findName = (datas, name) ->
  for data in datas
    if data.value.name == name
      return data
  return null

module.exports = (robot) ->
  robot.hear /[\w]*\+{2}$/, (msg) ->
    name = msg.match[0].replace '++', ''
    dataStore.stream().size(100).next( (err, datum) ->
      data = findName datum, name
      value = 0
      if data == null
        dataStore.push({'content': 0, 'name': name} , (pushErr, pushed) ->
          msg.send pushErr
          )
      else
        id = data.id
        value = data.value.content + 1
        dataStore.set id, 'content': value
      msg.send name + " +1 (now " + value + " points)"
      )
