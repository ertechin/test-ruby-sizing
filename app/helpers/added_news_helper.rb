module AddedNewsHelper
  def get_image_indexes(images_count, selected)
    values = []
    for count in 1..images_count do
      values << count
    end
    options_for_select(values.map { |name| [name] }, selected)
  end
end
