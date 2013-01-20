class Article
  include Tire::Model::Persistence
  #include Tire::Model::Callbacks

  before_save :assign_id

  property :title
  property :link
  property :published_on
  property :tags
  property :metadata

  private
  def assign_id
    self.id = self.link.split('/').last if self.id.blank? && self.link.present?
  end
end
