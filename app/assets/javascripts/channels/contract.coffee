document.addEventListener 'turbolinks:load', ->
    if App.contract
      App.cable.subscriptions.remove App.contract
    App.contract = App.cable.subscriptions.create { channel: "ContractChannel", contract: $('#messages').data('contract_id'), sender: $('#messages').data('sender') },
      #通信が確立された時
      connected: ->
      #通信が切断された時
      disconnected: ->
      #値を受け取った時
      received: (data) ->
        #投稿を追加
        $('#messages').append data['message']
      #サーバーサイドのspeakアクションにdirect_messageパラメータを渡す
      speak: (message) ->
        @perform 'speak', message: message

    $('#chat-input').on 'keypress', (event) ->
      #return キーのキーコードが13
      if event.keyCode is 13
        #speakメソッド,event.target.valueを引数に.
        App.contract.speak event.target.value
        event.target.value = ''
        event.preventDefault()



