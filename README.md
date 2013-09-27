# Ans::Enum

列挙型クラスを生成する

## Installation

Add this line to your application's Gemfile:

    gem 'ans-enum'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ans-enum

## Usage

    # model
    class MyModel < ActiveRecord::Base
      include Ans::Enum

      enum_of :my_status, [:busy,:work,:wait]

      def my_status
        case
        when some_case
          my_status_busy
        when other_case
          my_status_work
        when maybe
          my_status_wait
        else
          my_status_null
        end
      end
    end

    # erb
    <% status = @my_model.my_status %>
    <% case %>
    <% when status.busy? %>
      <%= 手が離せません %>
    <% when status.work? %>
      <%= 現在作業中ですが何かあれば受け付けます %>
    <% when status.wait? %>
      <%= ひま %>
    <% else %>
      <%= 本日は閉店しました %>
    <% end %>

Ans::Enum クラスを include すると、 `enum_of` クラスメソッドが定義されます  
このメソッドは第一引数に列挙型の名前、第二引数にシンボルの配列を指定します

モデルには `#{列挙型の名前}_#{項目名}` のメソッドが追加され、それぞれ、ステータスを保持したオブジェクトを返します

このオブジェクトは、 `enum_of` の第二引数で指定した名前のステータスであるかどうかを確認するメソッドを持ちます  
上記なら `busy?`, `work?`, `wait?` が定義されます

暗黙的に、モデルには `#{列挙型の名前}_null` メソッドも同時に追加されます  
これは、上記なら `busy?`, `work?`, `wait?` のどれに対しても false で答える、 null オブジェクトです  
場合によっては必要になるでしょう

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
