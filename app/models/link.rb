class Link < ApplicationRecord
  has_many :clicks, dependent: :destroy

  validates :original_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
end
