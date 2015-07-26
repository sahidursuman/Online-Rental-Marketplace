class Photo < ActiveRecord::Base
  belongs_to :item
  mount_uploader :image, ImageUploader

   def self.parse_filename(filename)
    filename.gsub!(/(.jpg|.png)/, '')
    return nil unless filename =~ /^\w*-(([a-zA-Z])*(_|$))*/
    filename.split('_').join(' ')
    {title: filename}
  end
end
