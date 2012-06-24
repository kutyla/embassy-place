require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @valid_post_params = lambda {{
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph }}

    @post = Post.create(@valid_post_params.call)
  end

  test "should find by permalink" do
    assert_equal @post._id, Post.find_by_permalink(@post.permalink)._id
  end

  test "should find active posts" do
    Post.all.collect(&:destroy)
    active = Post.create!(@valid_post_params.call)
    deleted = Post.create!(@valid_post_params.call)
    assert Post.active.to_a.include?(deleted)
    deleted.mark_as_deleted!
    assert !Post.active.to_a.include?(deleted)
  end

  test "should set permalink on create" do
    post = Post.new(@valid_post_params.call)
    assert_equal nil, post.permalink
    post.save
    assert_not_nil post.permalink
  end

  test "should set permalink when title is changed" do
    original_permalink = @post.permalink
    @post.title = Faker::Lorem.sentence
    @post.save
    assert @post.permalink != original_permalink
  end

  test "should not change permalink if title isn't changed" do
    original_permalink = @post.permalink
    @post.content = Faker::Lorem.paragraph
    @post.save
    assert_equal original_permalink, @post.permalink
  end

  test "should number posts sequentially" do
    post_1 = Post.create!(@valid_post_params.call)
    post_2 = Post.create!(@valid_post_params.call)
    assert_equal post_2.placement, (post_1.placement + 1)
  end

  # next
  test "next should return newer post" do
    first = Post.create!(@valid_post_params.call)
    third = Post.create!(@valid_post_params.call)
    second = Post.create!(@valid_post_params.call)
    third.update_attribute(:placement, (second.placement + 1))

    assert_equal first.next, second
    assert_equal second.next, third
    assert_equal third.next, nil
  end

  # previous
  test "previous should return older post" do
    Post.all.collect(&:destroy)
    first = Post.create!(@valid_post_params.call)
    third = Post.create!(@valid_post_params.call)
    second = Post.create!(@valid_post_params.call)
    third.update_attribute(:placement, (second.placement + 1))

    assert_equal first.previous, nil
    assert_equal second.previous, first
    assert_equal third.previous, second
  end

  # mark_as_deleted!
  test "mark_as_deleted should set deleted_at" do
    post = Post.create!(@valid_post_params.call)
    assert_nil post.deleted_at
    post.mark_as_deleted!
    post.reload
    assert_not_nil post.deleted_at
  end

end
