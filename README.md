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

      enum_of :my_status, [:busy,:work,:wait,:closed]

      def my_status
        case
        when full_time_busy?  then my_status_busy
        when busy_time_exist? then my_status_work
        when working?         then my_status_wait
        when closed?          then my_status_closed
        else
          my_status_null
        end
      end
    end

    # erb
    <% status = @my_model.my_status %>
    <% case %>
    <% when status.busy? %>
      手が離せません
    <% when status.work? %>
      現在作業中ですが何かあれば受け付けます
    <% when status.wait? %>
      ひま
    <% when status.closed? %>
      本日は閉店しました
    <% else %>
      どの状態でもありません
    <% end %>

Ans::Enum クラスを include すると、 `enum_of` クラスメソッドが定義されます  
このメソッドは第一引数に列挙型の名前、第二引数にシンボルの配列を指定します

* 第二引数の中に `:null` は含められません(含めても期待した結果にはなりません : 後述)  
  null オブジェクトで満足できるかどうか検討してみてください
* `enum_of` を、同じ第一引数で複数回呼び出すとあまり良くないです  
  一回の呼び出しで完全に定義することが困難な場合は、作者に連絡してこの問題を解決させるように促してください

## Spec

モデルには `#{列挙型の名前}_#{項目名}` のメソッドが追加され、それぞれ、ステータスを保持したオブジェクトを返します

このオブジェクトは、 `enum_of` の第二引数で指定した名前のステータスであるかどうかを確認するメソッドを持ちます  
上記なら `busy?`, `work?`, `wait?` が定義されます

`to_s` メソッドも定義され、`"#{項目名}"` が戻ります

暗黙的に、モデルには `#{列挙型の名前}_null` メソッドも同時に追加されます  
これは、 `busy?`, `work?`, `wait?` のどれに対しても false で答える、 null オブジェクトです  
「どの状態でもない状態」というのは、場合によっては必要になります

`#{列挙型の名前}_null` メソッドで返されるオブジェクトは、常に null オブジェクトです  
項目に `:null` を含めて、明示的に `null` のステータスを作成したつもりでも、 `null?` で返されるのは false です  
列挙項目名に `:null` を含められない、と書いたのは、これが理由です

null オブジェクトかどうかを確かめるには、 `to_s` を呼び出して `"null"` であることを確かめる、という方法がありますが、  
null オブジェクトかどうかを確かめる必要があるなら、それは何かの状態を表しているはず。  
名前をつけて列挙項目に含められるかどうか検討してください

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
