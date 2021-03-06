class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

  has_many :assets
  accepts_nested_attributes_for :assets
  has_many :comments
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
                                    class_name: "User"
  belongs_to :state

  attr_accessor :tag_names
  before_create :associate_tags

  def self.search(query)
    query
      .split(" ")
      .collect do |query|
        query.split(":")
      end.inject(self) do |klass, (name, q)|
        association = klass.reflect_on_association(name.to_sym)

        unless association
          name = name.pluralize
          association = klass.reflect_on_association(name.to_sym)
        end

        association_table = association.klass.arel_table

        if [:has_and_belongs_to_many,
            :belongs_to].include?(association.macro)
          joins(name.to_sym).where(association_table["name"].eq(q))
        else
          all
        end
      end
  end

  private

  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
end
