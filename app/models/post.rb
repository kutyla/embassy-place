class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :content
  field :permalink
  field :placement
  field :deleted_at, type: Time

  before_validation :set_permalink, if: :set_permalink?
  validates_uniqueness_of :permalink
  validates_presence_of :title
  validates_presence_of :content
  before_create :set_placement

  class << self
    def find_by_permalink(string)
      where({ permalink: string}).first
    end

    def active
      where({ deleted_at: nil })
    end
  end

  def to_param
    self.permalink
  end

  def next
    Post.active.where({ placement: { "$gt" => self.placement } }).order_by([:placement, :asc]).first
  end

  def previous
    Post.active.where({ placement: { "$lt" => self.placement } }).order_by([:placement, :desc]).first
  end

  def mark_as_deleted!
    self.update_attribute(:deleted_at, Time.now)
  end

  private

  def set_permalink?
    (permalink.blank? || title_changed?)
  end

  def set_permalink
    self.permalink = Permalink.new(title)
  end

  def set_placement
    current_placement = Post.order_by([:placement, :desc]).first.try(:placement)
    current_placement ||= 0
    self.placement = (current_placement + 1)
  end

end
