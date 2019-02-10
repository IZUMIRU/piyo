class AddOgpImagesToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :ogp_image, :string
  end
end
