require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # ↓このコードは慣習的に正しくない
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
    # ↓正しい(userに紐付いた新しいMicropostオブジェクトを返す)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  # 作成したマイクロポストが有効かチェック
  test "should be valid" do
    assert @micropost.valid?
  end

  # user_idの存在性のバリデーションをテスト
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  # contentの存在性のバリデーションをテスト
  test "content should be present" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  # マイクロポストが140文字より長くならないようにする
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  # データベース上の最初のマイクロポストがfixture内のマイクロポストと同じであるか検証する
  test "oder should be most recernt first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
